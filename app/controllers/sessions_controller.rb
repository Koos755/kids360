class SessionsController < ApplicationController

  def new

  end

  def create
    parent = Parent.find_by(params[:email])
    if  parent.present? && parent.authenticate(params[:password])
      session[:parent_id] = parent.id
      redirect_to parent_url(parent)
    else
      flash.now[:error] = "Something went wrong, please try again."
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Successfully signed out"
  end

end
