class ManageController < ApplicationController

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:success] = "Employee was successfully saved."
      redirect_to manage_index_path
    else
      render :new
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      flash[:success] = "Employee was successfully updated."
      redirect_to manage_index_path
    else
      render 'edit'
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    flash[:success] = "Employee was successfully deleted."
    redirect_to manage_index_path
  end

  def arrival_report
    if params[:id]
      @employee = Employee.find(params[:id])
    else
      redirect_to manage_index_path
    end
  end

  def arrival_report_section
    if params[:id] && params[:from]
      @working_periods = Employee.get_working_time_period params
      render :layout => false
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :phone_number, :address, :password)
  end
end
