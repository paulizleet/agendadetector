class CreateArchives < ActiveRecord::Migration[5.0]
  def change

    create_table :archive_threads do |t|
      t.belongs_to :chan_board, index: true
      t.string :op
      t.timestamps
    end

    create_table :archive_posts do |t|
      t.belongs_to :archive_thread, index: true
      t.string :chan_board_id
      t.string :text_hash
      t.string :post_num
      t.string :poster_id
      t.string :text
      t.string :post_timestamp
      t.timestamps
    end

    create_table :archive_counters do |t|
      t.belongs_to :chan_board, index: true
      t.string :chan_board_id
      t.string :text_hash
      t.integer :occurrences
      t.timestamps
    end
  end
end
