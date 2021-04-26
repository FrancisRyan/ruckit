class OffersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_offer, only: [:accept, :reject]
    before_action :is_authorised, only: [:accept, :reject]

    def create
        req = Request.find(offer_params[:request_id])

        if req && req.user_id == current_user.id
            redirect_to request.referrer, alert: "You cannot offer your own request"
        end

        if Offer.exists?(user_id: current_user.id, request_id: offer_params[:request_id])
            redirect_to request.referrer, alert: "You can make only one offer at the moment"
        end

        @offer = current_user.offers.build(offer_params)
        if @offer.save
            # redirect_to request.referrer, notice: "Saved..."
            redirect_to my_offers_path, notice: "Saved..."
        else
           flash[:alert] = "You have already made a challenge to this fixture"
        end
        
    end

    def accept
        if @offer.pending?
            @offer.accepted!

            if charge(@offer.request, @offer)
                flash[:notice] = "Accepted..."
                return redirect_to challenging_challenges_path
            else
                flash[:alert] = "cannot create your Challenge"
            end
        end
        redirect_to request.referrer
    end

    def reject
        if @offer.pending?
            @offer.rejected!
            flash[:notice] = "Rejected..."
        end
        redirect_to request.referrer
    end

    private

    def charge(req, offer)
        challenge = req.challenges.new
       
        challenge.title = req.title
        challenge.creator_name = offer.user.full_name
        challenge.creator_id = offer.user.id
        challenge.challenger_name = current_user.full_name
        challenge.challenger_id = current_user.id
      
       challenge.save
    end




    def set_offer
        @offer = Offer.find(params[:id])
    end

    def is_authorised
        redirect_to root_path, alert: "You don't have permission" unless current_user.id == @offer.request.user_id
    end

    def offer_params
        params.require(:offer).permit(:age, :location, :note, :request_id, :status)
    end
end