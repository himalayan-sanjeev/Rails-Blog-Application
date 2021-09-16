class CommentsController < ApplicationController
    
    def new
    end

    def create
      @comment=current_user.comment.new(comment_params)
      if !@comment.save
        flash[:notice]=@comment.errors.full_messages.to_sentence
      end
      redirect_to articles_path(params[:article_id])
    end

    def show 
    end
    
    def edit
    end

    def update
    end

    def destroy
    end

    private
    def comment_params
      params.require(:comment).permit(:content).merge(article_id: params[:article_id])
    end
end
