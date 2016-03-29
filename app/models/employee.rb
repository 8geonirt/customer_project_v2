# Employee documentation:
#
class Employee < ActiveRecord::Base

  validates :first_name, presence: true, length: { minimum: 3, maximum: 100}
  validates :last_name, presence: true, length: { minimum: 3, maximum: 100}
  validates :address, presence: true, length: { minimum: 3, maximun: 100}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  def self.get_working_time_period params
    if params[:to] != ""
      worked_days = WorkingTime.where("employee_id = ? and DATE(date) >= ? and DATE(date) <= ?",params[:id],params[:from], params[:to]).order(:date)
    else
      worked_days = WorkingTime.where("employee_id = ? and DATE(date) = ?",params[:id],params[:from]).order(:date)
    end
    calculator = WorkerHoursCalculator.new
    calculator.calculate_worked_hours worked_days
  end

end
