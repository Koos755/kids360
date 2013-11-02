class Dashboard

  attr_reader :parents_count, :children_count, :approved_organizations, :suggested_organizations, :doctors_count

  def initialize
    @parents_count = Parent.count
    @children_count = Child.count
    @approved_organizations = Organization.where(active: true).count
    @doctors_count = Doctor.count
    @suggested_organizations = Organization.where(active: nil)
  end

end

