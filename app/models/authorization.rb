class Authorization < ActiveRecord::Base

  belongs_to :child
  belongs_to :organization

  validates :child_id, presence: true
  validates :organization_id, presence: true,:uniqueness => { :scope => :child_id, :message => 'already authorized for this child.' }

end
