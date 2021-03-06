class ManageController < ApplicationController

  before_action :is_not_admin?

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
    @working_periods = Employee.get_report params
    render :layout => false
  end

  def working_time
    if params[:id]
      @working_time = Employee.get_working_time params
      if !@working_time[:is_available]
        flash[:danger] = "You can not have access to the hour report, it is only available three days before the paycheck day."
        redirect_to manage_index_path
      end
    else
      redirect_to manage_index_path
    end
  end

  def add_entry_time
    if params[:id]
      @employee = Employee.find(params[:id])
    end
  end

  def save_entry
    if params[:employee_id]
      if Employee.save_record_time? params
        flash[:success] = "Entry recorded successfully"
        redirect_to manage_index_path
      end
    else
      redirect_to manage_index_path
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :phone_number, :address, :password)
  end

  def is_not_admin?
    if !current_employee.admin?
      redirect_to home_unauthorized_path
    end
  end

end
