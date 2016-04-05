class AddDeviseToEmployees < ActiveRecord::Migration
  def self.up
    change_table(:employees) do |t|
      add_column :confirmation_token,   :string
      add_column :confirmed_at,         :datetime
      add_column :confirmation_sent_at, :datetime
      add_column :unconfirmed_email,    :string
      ## Database authenticatable

    end
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
