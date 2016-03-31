class WorkerHoursCalculator

  # Returns a hash containing the following keys: total_days, total_worked, also contains keys for every day the employee has been working on.
  # Params:
  # +worked_days+:: Array of WorkingTime objects fetched from a database query (days recorded that the employee has been working)
  # ==== Example:
  # worked_days = [WorkingTime.new(id:1, date: '2016-03-28 09:30:00'),WorkingTime.new(id:2, date: '2016-03-28 10:30:00'),WorkingTime.new(id:3, date: '2016-03-28 12:30:00')]
  # Result:
  #
  # {
  #   total_worked: 3
  #   total_days: 1
  #   '2016-03-28': { total: 3.0, arrival_hour: 'Mon, 28 Mar 2016 09:30:00', departur_hour: 'Mon, 28 Mar 2016 12:30:00'  }
  # }
  #
  # The array must be greater than 1 in order to calculate worked hours.
  def calculate_worked_hours worked_days
    hash = Hash.new([])
    hash[:total_days] = 0
    hash[:total_worked] = 0
    if worked_days.size > 1
      hash = get_worked_hours_hash(get_hours_array(worked_days), hash)
    end
    return hash
  end

  def get_difference_days start_date, end_date
    days_difference = (((end_date.to_time - start_date.to_time) / 1.days ).round(2) - 1)
    days_difference *= -1 if days_difference < 0
    return days_difference
  end

  def get_not_worked_days start_date, end_date, employee_id
    not_worked_days = []
    for i in 0..get_difference_days(start_date, end_date) + 1
      current_date = start_date + i.days
      if didnt_come_to_work? employee_id, current_date
        not_worked_days << current_date
      end
    end
    return not_worked_days
  end

  private

  def didnt_come_to_work? employee_id, date
    WorkingTime.where("employee_id = ? and DATE(date) = ?",employee_id, date.strftime("%F")).size == 0
  end

  # Returns true if the days given are different
  def is_different_day? day1, day2
    day1 != day2
  end

  # Iterates an array containing the hours recorder by the system (record machine) and returns a hash containing the result of worked hours in a specific day
  # Parameters:
  # +hours_array+:: array of hours
  # +hash+:: initialized hash
  def get_worked_hours_hash hours_array, hash
    first_hour_pos = 0
    hours_array.each do |hour|
      if is_different_day? hour.day, hours_array[first_hour_pos].day
        current_day = hours_array[first_hour_pos]
        first_hour_pos = hours_array.index(hour)
        worked_hours = get_worked_hours(current_day, hours_array[first_hour_pos - 1])
        hash = build_hash hash, current_day, worked_hours, hours_array[first_hour_pos - 1]
      elsif hours_array.index(hour) == hours_array.size - 1
        worked_hours = get_worked_hours(hours_array[first_hour_pos], hours_array[hours_array.size - 1])
        hash = build_hash hash, hours_array[first_hour_pos], worked_hours, hours_array[hours_array.size - 1]
      end
    end
    return hash
  end

  # Returns a hash containing the hours worked, from an hours array given
  def build_hash hash, date, worked_hours, departur_hour
    hash["#{date.strftime("%F")}"] = {total: worked_hours, arrival_hour: date, departur_hour: departur_hour}
    hash[:total_worked] += worked_hours
    hash[:total_days] += 1
    return hash
  end

  # Returns the hours worked  between two hours given
  # +start_time+:: First time recorded of a laboral day for an employee
  # +end_time+:: Last time recorded of a laboral day for an employee
  # ==== Example:
  # @start_time = '2016-03-28 09:00:00'
  # @end_time = '2016-03-28 17:00:00'
  # result = 8.0
  def get_worked_hours start_time, end_time
    start_time = DateTime.new(start_time.year, start_time.month, start_time.day, start_time.hour, start_time.min, start_time.sec)
    end_time = DateTime.new(end_time.year, end_time.month, end_time.day, end_time.hour, end_time.min, end_time.sec)
    hours_diff = ((end_time.to_time - start_time.to_time) / 1.hours ).round(2)
    hours_diff *= -1 if hours_diff < 0
    return hours_diff
  end

  # Returns an array of dates extracted from a WorkingTime array
  def get_hours_array hours
    hours_array = []
    hours.each { |h| hours_array << h.date }
    return hours_array
  end

end
