class ChallengesController < ApplicationController
    before_action :authenticate_user!
    before_action :is_authorised, only: [:show]
    
    def create
        fixture = Fixture.find(params[:fixture_id])
        detailing = fixture.detailings.find_by(detailing_type: params[:detailing_type])

        if (detailing && !fixture.has_single_detailing) 
               charge(fixture, detailing)
        else
            flash[:alert] = "Details are incorrect"
        end

        redirect_to challenging_challenges_path
    end

    def creating_challenges
        @challenges = current_user.creating_challenges
    end

    def challenging_challenges
        @challenges = current_user.challenging_challenges
    end

  def accepted
        @challenge = Challenge.find(params[:id])

        if !@challenge.accepted?
            if @challenge.accepted!
                flash[:notice] = "Saved..."
            else
                flash[:aler] = "Something went wrong..."
            end
redirect_to request.referrer
            
        else
        
        if !@challenge.rejected?
            if @challenge.rejected!
                flash[:notice] = "Saved..."
            else
                flash[:aler] = "Something went wrong..."
            end

            
        end
        redirect_to request.referrer
  end
 end


    def show
        @challenge = Challenge.find(params[:id])
        @fixture = @challenge.fixture_id ? Fixture.find(@challenge.fixture_id) : nil
        @request = @challenge.request_id ? Request.find(@challenge.request_id) : nil
        @comments = Comment.where(challenge_id: params[:id])
    end



     private
     
    def is_authorised
        redirect_to dashboard_path, 
            alert: "You don't have permission" unless Challenge.where("id = ? AND (creator_id = ? OR challenger_id = ?", 
                                                                    params[:id], current_user.id, current_user.id)
    end


    def charge(fixture, detailing)
        challenge = fixture. challenges.new
         challenge.due_date = Date.today() + detailing.match_time.days
         challenge.title = fixture.title
         challenge.creator_name = fixture.user.full_name
         challenge.creator_id = fixture.user.id
         challenge.challenger_name = current_user.full_name
         challenge.challenger_id = current_user.id
         
         
         if challenge.save
             flash[:notice] = "Your challenge is created successfully"
         else
             flash[:alert] = challenge.errors.full_message.join(",")
         end
    end
end