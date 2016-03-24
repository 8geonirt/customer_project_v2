class CreateWorkingTimeTable < ActiveRecord::Migration

  def change
    create_table :working_times do |t|
      t.datetime :date
      t.integer :employee_id
    end
  end

end
