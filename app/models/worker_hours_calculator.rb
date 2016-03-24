class WorkerHoursCalculator

  def calculate_worked_hours worked_days, option = 1
    hours_worked = Hash.new([])
    if worked_days.size > 1
      first_hour = worked_days.first
      last_hour = worked_days.last
      if first_hour != last_hour
        first_hour_pos = 0
        hours_worked = get_worked_hours_hash(get_hours_array(hours_worked))
      else
        hours_worked = get_worked_hours_hash worked_days
      end
    end
  end

  private

  def get_worked_hours_hash hours_array

  end

  def get_worked_hours start_time, end_time
    hours_diff = ((end_time.to_time - start_time.to_time) / 1.hours ).round(2)
    hours_diff *= -1 if hours_diff < 0
    return hours_diff
  end

  def get_hours_array hours
    hours_array = []
    hours.each { |h| hour_array << hour.date }
    return dates
  end

end
