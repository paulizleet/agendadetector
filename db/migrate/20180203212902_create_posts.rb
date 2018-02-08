class CreatePosts < ActiveRecord::Migration[5.0]
  def change

    create_table :posts do |t|
      t.string :text_hash
      t.string :board
      t.string :op
      t.string :post_num
      t.string :poster_id
      t.string :text
      t.string :post_timestamp
      t.timestamps
    end

  end
end
