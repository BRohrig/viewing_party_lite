class ApplicationController < ActionController::Base
  def user_check
    if session[:user_id] != params[:id]
      flash[:error] = "You Must Be Logged in to Visit this Page"
      redirect_to root_path
    end
  end
end
