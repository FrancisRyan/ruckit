class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
  end

 def show
    @user = User.find(params[:id])
    @reviews = Review.where(creator_id: params[:id]).challenge("created_at desc")
 end

  def update
    @user = current_user
    if @user.update_attributes(current_user_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Cannot update..."
    end
    redirect_to dashboard_path
  end

 def update_checkout
    if !current_user.checkout_id
      customer = Checkout::Customer.create(
        email: current_user.email,
        source: params[:user_id]
      )
    else
      customer = Checkout::Customer.update(
        current_user.checkout_id,
     source: params[:user_id]
      )
    end

end
    private
    
      def current_user_params
        params.require(:user).permit(:from, :about, :status, :team, :avatar)
      end
 end