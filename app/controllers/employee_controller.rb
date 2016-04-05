class EmployeeController < ApplicationController

  skip_before_action :authenticate_employee!, only: [:index]
  def index

  end

  def profile

  end

  def update

  end

end
