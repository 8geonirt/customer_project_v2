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

  test 'Recorder hours must be greater than 1 record in order to calculate worked hours' do
    assert @worked_days.size > 1
  end

  test 'Worked hours must be equals to 8' do
    @worked_days = [parse_hour(2016,3,28,9,0,0),parse_hour(2016,3,28,17,0,0)]
    result =  @calculator.calculate_worked_hours @worked_days
    assert result[:total_worked], 8
  end

end
