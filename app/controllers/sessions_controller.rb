class SessionsController < ApplicationController

  def new

  end

  def create
    parent = Parent.find_by(email: params[:email])
    if  parent.present? && parent.authenticate(params[:password])
      flash[:notice] = "Successfully signed in!"
      session[:parent_id] = parent.id
      redirect_to parent_url(parent)
    else
      flash[:error] = "Something went wrong, please try again."
      render 'new'
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Successfully signed out"
    redirect_to root_url
  end

end
