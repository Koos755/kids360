class Dashboard

  attr_reader :parents_count, :children_count, :approved_organizations, :suggested_organizations

  def initialize
    @parents_count = Parent.count
    @children_count = Child.count
    @approved_organizations = Organization.where(active: true).count
    @suggested_organizations = Organization.where(active: nil)
  end

end

