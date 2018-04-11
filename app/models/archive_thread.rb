class ArchiveThread < ApplicationRecord
  belongs_to :chan_board
  has_many :archive_posts
  def new_post(post)
    @post = self.archive_posts.new(
        chan_board_id: post.chan_board_id,
        text_hash: post.text_hash,
        post_num: post.post_num,
        poster_id: post.poster_id,
        text: post.text,
        post_timestamp: post.post_timestamp
      )

    @arc_counter = ArchiveCounter.find_by(text_hash: @post.text_hash)
    if @arc_counter == nil
      @arc_counter = ArchiveCounter.new(text_hash: @post.text_hash, occurrences: 1)
    else
      @arc_counter.occurrences + 1
    end

    @arc_counter.save
    @post.save
    @post.increment
  end
end
