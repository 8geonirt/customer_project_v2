# Employee documentation:
#
class Employee < ActiveRecord::Base

  validates :first_name, presence: true, length: { minimum: 3, maximum: 100}
  validates :last_name, presence: true, length: { minimum: 3, maximum: 100}
  validates :address, presence: true, length: { minimum: 3, maximun: 100}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  def self.get_arrival_report params
    get_worked_hours get_worked_days(params)
  end

  def self.get_working_time params
    hash = Hash.new([])
    now = Time.now
    first_payday = 15
    second_payday = now.end_of_month.day
    if review_is_available? first_payday, second_payday
      hash[:is_available] = true
      if now.day < 15
        hash[:from] = now - (now.day - 1).days
        hash[:to] = (now - (now.day - 1).days) + 15.days
      else
        hash[:from] = (now - (now.day - 1).days) + 15.days
        hash[:to] = (now - (now.day - 1).days) + second_payday.days
      end
      hash[:id] = params[:id]
      hash[:worked_days] = get_worked_days hash
      hash[:total_worked] = get_worked_hours hash[:worked_days]
      hash[:employee] = Employee.find(params[:id])
    else
      hash[:is_available] = false
    end
    return hash
  end

  private

  def self.review_is_available? day1, day2
    return true
=begin    now = Time.now
    if !(day1 - now.day == 3 || day2 - now.day == 3)
      return false
    end
=end
  end

  def self.get_worked_days params
    if params[:to] != ""
      worked_days = WorkingTime.where("employee_id = ? and DATE(date) >= ? and DATE(date) <= ?",params[:id],params[:from], params[:to]).order(:date)
    else
      worked_days = WorkingTime.where("employee_id = ? and DATE(date) = ?",params[:id],params[:from]).order(:date)
    end
    return worked_days
  end

  def self.get_worked_hours worked_days
    calculator = WorkerHoursCalculator.new
    calculator.calculate_worked_hours worked_days
  end

end
