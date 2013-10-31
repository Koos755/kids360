class Dashboard

  # attr_accessor :organizations, :
  attr_reader :parents_count, :children_count

  def initialize
    @parents_count = Parent.count
    @children_count = Child.count
    @approved_organizations = Organizations.
  end
end

