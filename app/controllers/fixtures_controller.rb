class FixturesController < ApplicationController
  
  protect_from_forgery except: [:upload_photo]
  before_action :authenticate_user!, except: [:show]
  before_action :set_fixture, except: [:new, :create]
  before_action :is_authorised, only: [:edit, :update, :upload_photo, :delete_photo]
  before_action :set_step, only: [:update, :edit]
  
  def new
    @fixture = current_user.fixtures.build
    @categories = Category.all
  end

   def create
    @fixture = current_user.fixtures.build(fixture_params)

    if @fixture.save
      @fixture.detailings.create(Detailing.detailing_types.values.map{ |x| {detailing_type: x} })
      redirect_to edit_fixture_path(@fixture), notice: "Save..."
    else
      redirect_to request.referrer, flash: { error: @fixture.errors.full_messages }
    end
   end

   def edit
    @categories = Category.all
   end

  def update

    if @step == 2
      fixture_params[:detailings_attributes].each do |index, detailing|
        if @fixture.has_single_detailing && detailing[:detailing_type] != Detailing.detailing_types.key(0)
          next;
        else
          if detailing[:title].blank? || detailing[:description].blank? || detailing[:match_time].blank? || detailing[:age].blank?
            return redirect_to request.referrer, flash: {error: "Invalid detail"}
          end
        end
      end
    end

    if @step == 3 && fixture_params[:description].blank?
      return redirect_to request.referrer, flash: {error: "Description cannot be blank"}
    end

    if @step == 4 && @fixture.photos.blank?
      return redirect_to request.referrer, flash: {error: "You don't have any photos"}
    end

    if @step == 5
      @fixture.detailings.each do |detailing|
        if @fixture.has_single_detailing && !detailing.mini?
          next;
        else
         if detailing[:title].blank? || detailing[:description].blank? || detailing[:match_time].blank? || detailing[:age].blank?
            return redirect_to edit_fixture_path(@fixture, step: 2), flash: {error: "Invalid detail"}
         end
        end
      end

      if @fixture.description.blank?
        return redirect_to edit_fixture_path(@fixture, step: 3), flash: {error: "Description cannot be blank"}
      elsif @fixture.photos.blank?
        return redirect_to edit_fixture_path(@fixture, step: 4), flash: {error: "You don't have any photos"}
      end
    end

    if @fixture.update(fixture_params)
      flash[:notice] = "Saved..."
    else
      return redirect_to request.referrer, flash: {error: @fixture.errors.full_messages}
    end

    if @step < 5
      redirect_to edit_fixture_path(@fixture, step: @step + 1)
    else
      redirect_to dashboard_path
    end

  end

  def show
    @categories = Category.all
  end
  
  def upload_photo
    @fixture.photos.attach(params[:file])
    render json: { success: true }
  end

  def delete_photo
    @image = ActiveStorage::Attachment.find(params[:photo_id])
    @image.purge
    redirect_to edit_fixture_path(@fixture, step: 4)
  end
  
 def checkout
      
   redirect_to checkout_path
 end
  
  private

  def set_step
    @step = params[:step].to_i > 0 ? params[:step].to_i : 1
    if @step > 5
      @step = 5
    end
  end
  
  
  def set_fixture
    @fixture = Fixture.find(params[:id])
  end

  def is_authorised
    redirect_to root_path, alert: "You do not have permission" unless current_user.id == @fixture.user_id
  end
  
  def fixture_params
    params.require(:fixture).permit(:title, :video, :description, :active, :category_id, :has_single_detailing, 
                                detailings_attributes: [:id, :title, :description, :match_time, :age, :detailing_type])
  end
end
