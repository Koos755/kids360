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
            flash[:notice] = "Your email has been confirmed! You can now use the system."
            token.destroy
            redirect_to parent_url(parent)
          end
        elsif token.token_type == "password_reset"
          @parent = Parent.find_by(id: token.parent_id)
          token.destroy
          render 'reset_password'
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

  def confirm
    token = Token.new
    if token.create_confirmation_token(current_parent)
      flash[:notice] = "Email to confirm email address sent!"
      redirect_to parent_url(current_parent)
    else
      flash[:error] = "Something went wrong, please try again."
      redirect_to root_url
    end
  end

  def reset
  end

  def submit_reset
    @email = params[:email]
    parent = Parent.find_by(email: @email)
    if  parent.present?
      tokens = Token.where(parent_id: parent.id)
      tokens.destroy_all
      token = Token.new
      token.create_password_reset_token(parent)
    else
      # ParentMailer.delay.no_account_email(@email)
      ParentMailer.no_account_email(@email).deliver
    end
    render 'email_send'
  end

  def new_password
    parent = Parent.find_by(id: params[:parent_id])
    parent.password = params[:password]
    parent.password_confirmation = params[:password_confirmation]
    if parent.save
      session[:parent_id] = parent.id
      ParentMailer.delay.password_changed(parent)
      # ParentMailer.password_changed(parent).deliver
      flash[:notice] = "Password Successfully changed"
      redirect_to parent_url(parent)
    else
      flash[:error] = "Something went wrong, please try again"
      redirect_to root_url
    end
  end

  def contact
    ParentMailer.delay.contact_form_email(params[:name], params[:email], params[:story])
    # ParentMailer.contact_form_email(params[:name], params[:email], params[:story]).deliver
    flash[:notice] = "Thx for making contact, we will be in touch soon!"
    redirect_to root_url
  end

  def thankyou
  end

  def confirmed
  end
end
