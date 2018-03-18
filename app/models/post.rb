class Post < ApplicationRecord

  belongs_to :post_counter, required: false
  def increment
    @counter = PostCounter.find_by
    if @counter == nil
      PostCounter.new(text_hash: self.text_hash, occurrences: 1).save
    else
      @counter.occurrences+=1
      @counter.save
    end

  end

  def archive

    @arc = Archive.new(
      text_hash: self.text_hash,
      board: self.board,
      op: self.op,
      post_num: self.post_num,
      poster_id: self.poster_id,
      text: self.text,
      post_timestamp: self.post_timestamp
    )
    @arc_counter = ArchiveCounter.find_by(text_hash: self.text_hash)
    if @arc_counter == nil
      ArchiveCounter.new(text_hash: self.text_hash, occurrences: 1).save
    else
      @arc_counter.occurrences + 1
      @arc_counter.save
    end
    @arc.save

  end
end
