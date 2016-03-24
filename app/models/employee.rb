# Employee documentation:
#
class Employee < ActiveRecord::Base

  validates :first_name, presence: true, length: { minimum: 3, maximum: 100}
  validates :last_name, presence: true, length: { minimum: 3, maximum: 100}
  validates :address, presence: true, length: { minimum: 3, maximun: 100}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

end
