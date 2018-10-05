class ArchivePost 
  include MongoMapper::Document

  key :text_hash
  key :post_num
  key :poster_id
  key :text
  key :post_timestamp

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
