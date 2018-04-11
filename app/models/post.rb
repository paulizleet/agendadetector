class Post < ApplicationRecord
  belongs_to :chan_thread
  #belongs_to :chan_board#, through: :chan_thread


  def increment
    @counter = PostCounter.find_by(chan_board_id: self.chan_board_id, text_hash: self.text_hash)
    if @counter == nil
      @counter = PostCounter.new(
          chan_board_id: self.chan_board_id,
          text_hash: self.text_hash,
          occurrences: 1)
    else
      @counter.occurrences+=1
    end
    @counter.save

  end

  def decrement
    @counter = PostCounter.find_by(chan_board_id: self.chan_board_id, text_hash: self.text_hash)
    @counter.occurrences-=1
    if @counter.occurrences == 0
      @counter.destroy
    else
      @counter.save
    end
  end
end
