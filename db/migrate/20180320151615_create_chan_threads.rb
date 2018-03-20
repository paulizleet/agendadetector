class CreateChanThreads < ActiveRecord::Migration[5.0]
  def change

    create_table :chan_boards do |t|

      t.string :board_id
      t.string :board_name
    end


    create_table :chan_threads do |t|

      t.string :op
      t.string :board_id
      t.timestamps
    end

    create_table :posts do |t|
      t.bigint :text_hash
      t.string :post_num
      t.string :poster_id
      t.string :text
      t.string :post_timestamp
      t.timestamps
    end

    create_table :post_counters do |t|
      t.bigint :text_hash
      t.integer :occurrences
      t.timestamps
    end
  end
end
