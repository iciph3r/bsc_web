class Admin::UsersController < AdminController

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_url, notice: 'User Deleted.'
  end

  private
    def user_params
      # Safe params here based off of permissions level.
    end
end
