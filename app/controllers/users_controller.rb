class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(params_user)
        if @user.save
            flash[:notice] = "Welcome to Alpha Blog #{@user.username}, you have successfully signed up"
            redirect_to articles_path
        else
            render 'new'
        end        
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def show
        @user = User.find(params[:id])
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(params_user)
            flash[:notice] = "You account information was successfully updated"
            redirect_to @user
        else
            render "edit"        
        end

    end

    private

    def params_user
        params.require(:user).permit(:username,:email,:password)
    end
end