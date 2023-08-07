class AddRolesToUser < ActiveRecord::Migration[7.0]
  def up
    create_enum :role, ["teacher", "student", "admin"]
    change_table :users do |t|
      t.enum :role, enum_type: "role", default: "teacher", null: false
    end
  end
  def down
    remove_column :users, :role
    # Rails 7.1 will have a drop_enum, but this version does not.
    execute <<-SQL
      DROP TYPE role;
    SQL
  end
end

