class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy]
  before_action :parent_is_current_parent, only: [:show, :edit, :update]

  def splash
    render layout: false
  end

  def show
    if @parent.email_confirmed
      if Child.where(parent_id: @parent.id).present?
      @children = Child.where(parent_id: @parent.id)
      end
    else
      render 'email_unconfirmed'
    end
  end

  def new
    @parent = Parent.new
  end

  def edit
  end

  def create
    @parent = Parent.new(parent_params)
    @parent.terms = Time.now
    respond_to do |format|
      if @parent.save
        session[:parent_id] = @parent.id
        token = Token.new
        token.create_confirmation_token(@parent)
        format.html { redirect_to @parent, notice: 'Parent was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @parent.update(parent_params)
        format.html { redirect_to @parent, notice: 'Parent was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private
    def set_parent
      @parent = Parent.find(params[:id])
    end

    def parent_is_current_parent
      if current_parent != @parent
        flash[:error] = "Nice try, you can only view your own account."
        redirect_to root_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parent_params
      params.require(:parent).permit(:first_name, :last_name, :phone_number, :email, :email_confirmed, :address, :city, :state, :zip, :password, :password_confirmation)
    end
end
