class AuthorizationsController < ApplicationController
  before_action :set_authorization, only: [:show, :edit, :update, :destroy]

  # GET /authorizations
  # GET /authorizations.json
  def index
    @authorizations = Authorization.all
  end

  # GET /authorizations/1
  # GET /authorizations/1.json
  def show
  end

  # GET /authorizations/new
  def new
    @authorization = Authorization.new
    @child = Child.find(params[:child])
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /authorizations/1/edit
  def edit
  end

  # POST /authorizations
  # POST /authorizations.json
  def create
    @authorization = Authorization.new
    @authorization.child_id = params[:child_id]
    @organization = Organization.find_by(name: params[:organization_name])
    respond_to do |format|
      if @organization.present?
        @authorization.organization_id = @organization.id
        if @authorization.save
           flash.now[:notice] = "Permission added for #{@authorization.organization.name}!"
           format.js
        else
          format.js { render 'failed_create' }
        end
      else
        @organization = Organization.new
        @organization.name = params[:organization_name]
        @child = Child.find(params[:child_id])
        flash.now[:error] = "Can't find that Organization, please add their details"
        format.js { render 'organizations/new'}
      end
    end
  end

  # PATCH/PUT /authorizations/1
  # PATCH/PUT /authorizations/1.json
  def update
    respond_to do |format|
      if @authorization.update(authorization_params)
        format.html { redirect_to @authorization, notice: 'Authorization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @authorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authorizations/1
  # DELETE /authorizations/1.json
  def destroy
    @authorization.destroy
    flash.now[:notice] = "Permission deleted for #{@authorization.organization.name}!"
    respond_to do |format|
      format.js { render 'destroy'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authorization
      @authorization = Authorization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def authorization_params
      params.require(:authorization).permit(:organization_id, :child_id)
    end
end
