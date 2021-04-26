class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :is_valid_challenge

    def create
        challenge = Challenge.find(comment_params[:challenge_id])

        if comment_params[:content].blank?
           # return redirect_to request.referrer, alert: "Invalid message"
            return render json: {success: false}
        end

        if challenge.challenger_id != current_user.id && challenge.creator_id != current_user.id
            return render json: {success: false}
       end

        @comment = Comment.new(
            user_id: current_user.id,
            challenge_id: challenge.id,
            content: comment_params[:content],
            attachment_file: comment_params[:attachment_file],
        )

        if @comment.save
             #redirect_to request.referrer, notice: "Comment sent..."
            CommentChannel.broadcast_to challenge, message: render_comment(@comment)
           return render json: {success: true}
        else
            # redirect_to request.referrer, alert: "Cannot create comment"
            return render json: {success: false}
        end
    end

    private

    def render_comment(comment)
        self.render_to_string partial: 'challenges/comment', locals: {comment: comment}
    end

    def comment_params
        params.require(:comment).permit(:content, :challenge_id, :attachment_file)
    end

    def is_valid_challenge
        redirect_to dashboard_path, alert: "Invalid challenge" unless Challenge.find(comment_params[:challenge_id]).present?
    end
end