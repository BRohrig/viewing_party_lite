class UsersController < ApplicationController
  before_action :user_check, only: :show
  
  def show
    @user = User.find(params[:id])
    @viewing_parties = @user.viewing_parties
    @parties_info = []
    @viewing_parties.each do |party|
      @parties_info << party.collect_display_data
    end
  end

  def discover_movies
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = 'User has been created!'
      redirect_to user_path(new_user)
    else
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}!"
      redirect_to user_path(user.id)
    else
      flash[:error] = "Credentials Invalid."
      redirect_to login_path
    end
  end


  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
