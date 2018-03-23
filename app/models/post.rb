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
    @counter.save

  end


  def archive

    @arc = Archive.new(
      text_hash: self.text_hash,
      chan_board_id: self.board,
      op: self.op,
      post_num: self.post_num,
      poster_id: self.poster_id,
      text: self.text,
      post_timestamp: self.post_timestamp
    )
    @arc_counter = ArchiveCounter.find_by(text_hash: self.text_hash)
    if @arc_counter == nil
      ArchiveCounter.new(text_hash: self.text_hash, occurrences: 1)
    else
      @arc_counter.occurrences + 1
    end


    @arc.save
    @arc_counter.save
  end
end
