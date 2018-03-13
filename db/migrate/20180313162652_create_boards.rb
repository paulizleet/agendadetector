class CreateBoards < ActiveRecord::Migration[5.0]
  def change

    create_table :boards do |t|
      t.string :board_id
      t.string :board_name
    end

  end
end
