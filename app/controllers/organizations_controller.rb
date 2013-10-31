class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :must_be_admin, only: [:show, :edit, :update, :destroy, :index, :create, :new, :activate]

  # GET /organizations
  # GET /organizations.json
  def activate
    @organization = Organization.find(params[:id])
    @organization.active = true
    if @organization.save
      flash[:notice] = 'Organization activated'
      redirect_to dashboard_url
    else
      flash[:error] = "Something went wrong"
      redirect_to dashboard_url
    end
  end

  def index
    @organizations = Organization.all
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  def modal_new
    @organization = Organization.new
    @child = Child.find(params[:id])
    respond_to do |format|
      format.js { render 'new'}
    end
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    @organization.active = true

      if @organization.save
        flash[:notice] = 'Organization was successfully created.'
        redirect_to organizations_url
      else
        render 'new'
      end
  end

  def create_add
    @organization = Organization.new
    @organization.name = params[:name]
    @organization.email = params[:email]
    respond_to do |format|
      if @organization.save
        @authorization = Authorization.new
        @authorization.child_id = params[:child_id]
        @authorization.organization_id = @organization.id
        if @authorization.save
          flash.now[:notice] ="Organization has been added, and submitted for approval."
          format.js { render 'create' }
        end
      else
        format.js {render 'failed_create'}
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :email)
    end

    def must_be_admin
      if current_parent.blank? || current_parent.admin != true
        flash[:notice] = "You are not authorized to access that page!"
        redirect_to root_url
      end
    end
end
