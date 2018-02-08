class CreatePostCounters < ActiveRecord::Migration[5.0]
  def change
    create_table :post_counters do |t|
      t.text :text_hash
      t.integer :occurrences
      t.timestamps
    end
  end
end
