class CreateChanthreads < ActiveRecord::Migration[5.0]
  def change
    create_table :chanthreads do |t|
      t.string :thread_id
      t.string :post_num
      t.timestamps
    end
  end
end
