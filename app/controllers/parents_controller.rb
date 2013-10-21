class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy]
  before_action :parent_is_current_parent, only: [:show, :edit, :update]

  # GET /parents
  # GET /parents.json
  # def index
  #   @parents = Parent.all
  # end

  def splash
    render layout: false
  end
  # GET /parents/1
  # GET /parents/1.json
  def show
    if @parent.email_confirmed != true
      render 'email_unconfirmed'
    end
    if Child.where(parent_id: @parent.id).present?
      @children = Child.where(parent_id: @parent.id)
    end
  end

  # GET /parents/new
  def new
    @parent = Parent.new
  end

  # GET /parents/1/edit
  def edit
  end

  # POST /parents
  # POST /parents.json
  def create
    @parent = Parent.new(parent_params)
    @parent.terms = Time.now
    respond_to do |format|
      if @parent.save
        format.html { redirect_to @parent, notice: 'Parent was successfully created.' }
        format.json { render action: 'show', status: :created, location: @parent }
      else
        format.html { render action: 'new' }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parents/1
  # PATCH/PUT /parents/1.json
  def update
    respond_to do |format|
      if @parent.update(parent_params)
        format.html { redirect_to @parent, notice: 'Parent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parents/1
  # DELETE /parents/1.json
  # def destroy
  #   @parent.destroy
  #   respond_to do |format|
  #     format.html { redirect_to parents_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
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
