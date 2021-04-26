class ReviewsController < ApplicationController

    def create
        challenge = Challenge.find(review_params[:challenge_id])

        if challenge && current_user.id == challenge.challenger.id
            if Review.exists?(challenge_id: review_params[:challenge_id], challenger_id: current_user.id)
                flash[:alert] = "You already made the review for this challenge"
            else
                review = Review.new(review_params)
                review.fixture = challenge.fixture
                review.challenger = current_user
                review.creator = challenge.creator

                if review.save
                    flash[:notice] = "Saved..."
                else
                    flash[:alert] = "Cannot create review"
                end
            end
        else
            flash[:alert] = "Invalid challenge"
        end
        redirect_to request.referrer
    end

    private

    def review_params
        params.require(:review).permit(:stars, :review, :challenge_id)
    end
end