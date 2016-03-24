class CreateEmployees < ActiveRecord::Migration

  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :email
      t.string :phone_number
      t.boolean :activated
      t.timestamps null: false
    end
  end

end
