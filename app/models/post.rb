class Post < ApplicationRecord

  def new

  end

  belongs_to :post_counter, required: false
  def increment
    @counter = PostCounter.find_by(text_hash: self.text_hash)

    if @counter == nil
      PostCounter.new(text_hash: self.text_hash, occurrences: 1).save
    else
      @counter.occurrences+=1
      @counter.save
    end

  end
end
