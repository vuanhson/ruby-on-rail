class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  # GET /users
  # GET /users.json
  def index
      @users = User.paginate(page: params[:page])  end

  # GET /users/1
  # GET /users/1.json
  def show
      @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
        log_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
    # Handle a successful save.
    else
    render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
          flash[:success] = "Profile updated"
          redirect_to @user
          else
          render 'edit'
      end
  end
  
  def edit
      @user = User.find(params[:id])
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
  end
  
  def logged_in_user
      unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
      end
  end
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
   
end
