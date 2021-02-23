class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update]


    def new
        @user = User.new
    end

    def create
        @user = User.new(params_user)
        if @user.save
            session[:user_id]  = @user.id 
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
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def edit
    end

    def update
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

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user
          flash[:alert] = "You can only edit your own profile"
          redirect_to @user
        end
    end
end