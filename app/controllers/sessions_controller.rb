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

  def token
    token = Token.find_by(value: params[:value])

    if token.present?
      if token.token_type == "confirmation"

      elsif token.token_type == "password_reset"
      else
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end
end
