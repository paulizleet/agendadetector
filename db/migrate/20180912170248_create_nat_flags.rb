class CreateNatFlags < ActiveRecord::Migration[5.0]
  def change
    create_table :nat_flags do |t|
      t.string :flag_id
      t.string :flag_name
      t.boolean :troll

      t.timestamps
    end
  end
end
