require 'test_helper'

class WorkedHoursCalculatorTest < ActiveSupport::TestCase

  def parse_hour year, month, day, hour, min, sec
    WorkingTime.new(date: DateTime.new(year, month, day, hour, min, sec))
  end

  def print_hash hash
    hash.each do |key,value|
      puts "Key: #{key}, Value: #{value}"
    end
  end

  def setup
    @calculator = WorkerHoursCalculator.new
    @worked_days = [WorkingTime.new(id:1, date: '2016-03-28 09:30:00'),WorkingTime.new(id:2, date: '2016-03-28 10:30:00'),WorkingTime.new(id:3, date: '2016-03-28 12:30:00')] 
    @worked_days = [WorkingTime.new(id:1,date:'2016-03-28 10:00:00')]
    @worked_days << WorkingTime.new(id:4, date: '2016-03-29 09:00:00')
    @worked_days << WorkingTime.new(id:5, date: '2016-03-29 15:00:00')
    @worked_days << WorkingTime.new(id:6, date: '2016-03-31 10:00')
    @worked_days << WorkingTime.new(id:7, date: '2016-03-31 18:30')
    @worked_days << WorkingTime.new(id:8, date: '2016-04-01 08:30')
    @worked_days << WorkingTime.new(id:8, date: '2016-04-01 18:30')
  end

  test 'Recorded hours must be greater than 1 in order to calculate worked hours' do
    assert @worked_days.size > 1
  end

  test 'Worked hours must be equals to 8' do
    @worked_days = [parse_hour(2016,3,28,9,0,0),parse_hour(2016,3,28,17,0,0)]
    result =  @calculator.calculate_worked_hours @worked_days
    assert_equal result[:total_worked], 8
  end

  test 'Difference of days between 2016-03-15 and 2016-04-01 must be equal to 16' do
    start_date = DateTime.parse("2016-03-15")
    end_date = DateTime.parse("2016-04-01")
    assert_equal @calculator.get_difference_days(start_date, end_date), 16
  end

  test 'Total days not worked must be equal to 16' do
    start_date = DateTime.parse("2016-03-15")
    end_date = DateTime.parse("2016-04-01")
    assert_equal @calculator.get_not_worked_days(start_date, end_date, 1).size, 18
  end

end
