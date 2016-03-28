# Working time documentation
#
class WorkingTime < ActiveRecord::Base
  belongs_to :employee
  validates :date, presence: true

end
