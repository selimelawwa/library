class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
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
        session[:user_id] = @user.id #sign in upon sign up
        #flash[:success] = "Welcome to The Book Shop, #{@user.fname}"
        redirect_to root_path
    else 
        render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      #flash[:success] = "#{@user.username}, your details have been succesfully edited!"
      redirect_to user_path(@user)
    else
      render 'edit'
  end
    
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
     session[:user_id] = nil
     session[:order_id] = nil
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
       params.require(:user).permit(:username, :fname, :address, :lname, :telephone, :email, :password)
    end
    
end
