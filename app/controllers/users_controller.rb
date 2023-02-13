# frozen_string_literal: true

class UsersController < ApplicationController
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
    user = User.new(user_params)
    if user.save
      flash[:success] = 'User has been created!'
      redirect_to user_path(user)
    elsif params[:password] != params[:password_confirmation]
      flash[:error] = "Passwords Must Match"
      redirect_to register_path
    elsif user.name == ""
      flash[:error] = "Please Input Name"
      redirect_to register_path
    else
      flash[:error] = 'Cannot use existing email'
      redirect_to register_path
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
