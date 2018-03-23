class CreateMemes < ActiveRecord::Migration[5.0]
  def change
    create_table :memes do |t|
      t.string :text_hash
      t.string :text
      t.timestamps
    end
  end
end
