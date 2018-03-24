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
    @post.save
    @post.increment
  end
end
