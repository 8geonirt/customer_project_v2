class InputDeviceParser

  # Receives the date sent from the input machine and parse it to the format yyyy-mm-dd HH:MM:ss
  def self.parse_date date
    date = nil
    begin
      date = Time.zone.date(date)
    rescue

    end

  end

end
