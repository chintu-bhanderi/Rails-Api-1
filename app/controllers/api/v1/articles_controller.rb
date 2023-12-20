class Api::V1::ArticlesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

    def index
        articles =  Article.all
        render json: articles, status: 200
    end

    def show
        puts "HII"
        article = Article.find(params[:id])
        
        if article
            render json: article, status: 200
        else 
            render json: { 
                error: "No such article"
             }
        end
    end

    def create 
        article = Article.new(
            title: arti_params[:title],
            body: arti_params[:body],
            author: arti_params[:author]
        )
        # puts "HII This is controller.."
        if article.save
            render json: article, status: 200
        else 
            render json: { 
                error: "Error Creating.."
             }
        end
    end

    def update
        article = Article.find_by(id: params[:id])
        if article
            article.update(title: params[:title], body: params[:body], author: params[:author])
            render json: article, status: 200
        else
            render json: {
                error: "Error Updating.."
            }
        end
    end

    def destroy
        article = Article.find_by(id: params[:id])
        if article
            article.destroy
            render json: "Article has been deleted"
        else
            render json: {
                error: "Error Updating.."
            }
        end
    end

    private 
    def arti_params
        params.require(:article).permit([
            :title,
            :body,
            :author
        ])
    end 

end
