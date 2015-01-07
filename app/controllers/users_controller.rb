class UsersController < ApplicationController
  before_action :logged_in_user?, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.active?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:notice] = 'Please check your email to acitvate your account.'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = 'Settings Updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      if params[:action] == 'update'
        params.require(:user).permit(:email, :password, :password_confirmation)
      else
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation)
      end
    end
end
