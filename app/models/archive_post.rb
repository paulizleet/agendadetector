class ArchivePost < ApplicationRecord
  belongs_to :archive_thread
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
end
