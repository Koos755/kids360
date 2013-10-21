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
      if (Time.now - token.created_at) < 7200
        if token.token_type == "confirmation"
          parent = Parent.find_by(id: token.parent_id)
          if parent.confirm
            flash[:success] = "Your email has been confirmed"
            token.destroy
            redirect_to parent_url(parent)
          end
        elsif token.token_type == "password_reset"
          @parent = Parent.find_by(id: token.parent_id)
          token.destroy
          render 'reset_password'
        else
          redirect_to root_url
        end
      else
        token.destroy
        flash[:error] = "That token has expired. Please repeat the request and complete action within 2 hours"
        redirect_to root_url
      end
    else
      flash[:error] = "Unknown token request"
      redirect_to root_url
    end
  end
end
