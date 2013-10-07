class Authorization < ActiveRecord::Base

  belongs_to :child
  belongs_to :organization

end
