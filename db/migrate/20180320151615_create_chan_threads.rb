class CreateChanThreads
  def change

    create_table :chan_boards do |t|

      t.string :board_id
      t.string :board_name
    end


    create_table :chan_threads do |t|
      t.belongs_to :chan_board, index: true
      t.string :op
      t.timestamps
    end

    create_table :posts do |t|
      t.belongs_to :chan_thread, index: true
      t.string :chan_board_id
      t.string :text_hash
      t.string :post_num
      t.string :poster_id
      t.string :nat_flag
      t.string :text
      t.string :post_timestamp
      t.timestamps
    end

    create_table :post_counters do |t|
      t.string :chan_board_id
      t.string :text_hash
      t.integer :occurrences
      t.timestamps
    end
  end
end
