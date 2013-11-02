class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :update, :destroy, :modal, :add_doctor]
  before_action :must_be_childs_parent, only: [:show, :edit, :update, :destroy, :modal, :add_doctor]

  # GET /children
  # GET /children.json
  def index
    @children = Child.all
  end

  # GET /children/1
  # GET /children/1.json
  def show
    respond_to do |format|
      format.js
      format.html { redirect_to parent_url(current_parent), notice: "Not Allowed"}
    end
  end

  # GET /children/new
  def new
    @child = Child.new
    @child.parent_id = Parent.find(params[:parent]).id

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /children/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /children
  # POST /children.json
  def create
    @child = Child.new(child_params)
    respond_to do |format|
      if @child.save
        if params[:child][:doctor_id] == 'New'
          @doctor = Doctor.new
          flash.now[:notice] = "Child added successfully! Please create the doctor:"
          format.js { render 'create_new_doctor' }
        else
          @child.doctor_id = params[:child][:doctor_id]
          @child.save
          flash.now[:notice] = "Child added successfully! You can now add permissions."
          format.js { render 'create' }
        end
      else
        format.js { render 'failed_create'}
      end
    end
  end

  def update
    respond_to do |format|
      if @child.update(child_params)
        if params[:child][:doctor_id] == 'New'
          @doctor = Doctor.new
          flash.now[:notice] = "Child edited successfully! Please create the doctor:"
          format.js { render 'create_new_doctor_from_edit' }
        else
          @child.doctor_id = params[:child][:doctor_id]
          @child.save
          flash.now[:notice] = "Child edited successfully!"
          format.js
        end
      else
        format.js { render 'failed_update'}
      end
    end
  end

  def destroy
    @child.destroy
    respond_to do |format|
      format.html { redirect_to children_url }
      format.json { head :no_content }
    end
  end

  def modal
    @authorization = Authorization.new
    @organizations = Organization.where(active: true)
    respond_to do |format|
      format.js
    end
  end

  def add_doctor
    @doctor = Doctor.new
    @doctor.name = params[:name]
    @doctor.phone = params[:phone]
    @doctor.email = params[:email]
    respond_to do |format|
      if @doctor.save
        @child.doctor_id = @doctor.id
        if @child.save
          flash.now[:notice] = "Doctor added and linked to #{@child.first_name}"
          format.js
        end
      else
        format.js { render 'failed_doctor_add'}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_child
      @child = Child.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def child_params
      params.require(:child).permit(:parent_id, :first_name, :last_name, :email, :phone_number, :dob, :gender, :school)
    end

    def must_be_childs_parent
      if current_parent.blank? || current_parent != @child.parent
        flash[:error] = "You are not authorized to view that page"
        redirect_to root_url
      end
    end
end
