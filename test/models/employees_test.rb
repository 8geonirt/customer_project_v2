require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  def setup
    @employee = Employee.new(first_name:"Jose", last_name:"Espinoza",address:"Mi calle", email:"trinoeg8@gmail.com",phone_number:"3121078193")
  end

  test 'Employee first name should not be empty' do
    @employee.first_name = " "
    assert_not @employee.valid?
  end

  test 'Employee first name should not be too short' do
    @employee.first_name = "as"
    assert @employee.first_name.size < 3, 'First name length should be greater or equal than 3'
  end

  test 'Employee first name should not be too long' do
    @employee.first_name = "a" * 101
    assert @employee.first_name.size > 100, 'First name length should be less or equal than 100'
    assert_operator @employee.first_name.size, :>, 100
  end

  test 'Employee last name should not be empty' do
    @employee.last_name = ""
    assert_not @employee.valid?
  end

  test 'Employee last name should not be too short' do
    @employee.last_name = "as"
    assert @employee.last_name.size < 3, "Last name length should be greater or equal than 3"
  end

  test 'Employee last name should not be too long' do
    @employee.last_name = "a" * 101
    assert @employee.last_name.size > 100, 'Last name length should be less or equal than 100'
  end

  test 'Address should not be empty' do
    @employee.address = ""
    assert_not @employee.valid?, 'Address should not be empty'
  end

  test 'Adress should not be too long' do
    @employee.address = "a" * 101
    assert @employee.address.size > 100, 'Address should not be too long'
  end

  test 'Email address should not be empty' do
    @employee.email = ""
    assert_not @employee.valid?, 'Email should not be empty'
  end

  test 'Email address should be valid' do
    @employee.email = "bad@correo"
    assert_not @employee.valid?, 'Email format must be correct'
  end

  test 'Email address should be unique' do
    @employee.save
    empl2 = @employee.dup
    assert_not empl2.valid?, 'Email must be unique'
  end

end
