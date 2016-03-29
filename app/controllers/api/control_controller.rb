class Api::ControlController < ApplicationController
  def show
    begin
      employee = Employee.find(params[:id])
      working_time = WorkingTime.new(date:params[:date], employee: employee)
      if working_time.save
        render json: working_time, status: 201
      else
        puts working_time.errors.full_message
        render json: '{"success":false, "message":"Something went wrong"}', status: 505
      end
    rescue Exception => ex
      puts ex.message
      render json: '{"success":false, "message":"Invalid request"}', status: 505
    end
  end
end
