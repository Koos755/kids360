class AuthorizationsController < ApplicationController
  before_action :set_authorization, only: [:show, :edit, :update, :destroy]
  before_action :only_parent_of_child, only: [:create]

  def new
    @authorization = Authorization.new
    @organizations = Organization.where(active: true)
    @child = Child.find(params[:child])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @authorization = Authorization.new
    @authorization.child_id = params[:child_id]
    @organization = Organization.find_by(id: params[:organization_id])
    respond_to do |format|
        @authorization.organization_id = @organization.id
        if @authorization.save
           flash.now[:notice] = "Permission added for #{@authorization.organization.name}!"
           format.js
        else
          format.js { render 'failed_create' }
        end
    end
  end

  def destroy
    if @authorization.child.parent != current_parent
      flash[:error] = 'You are not authorized for that action'
    end

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

    def only_parent_of_child
      child = Child.find(params[:child_id])
      if current_parent.blank? || child.parent != current_parent
        flash[:error] = "Unauthorized for this action"
        redirect_to root_url
      end
    end
end
