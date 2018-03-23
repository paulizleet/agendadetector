class ChanThread < ApplicationRecord
    belongs_to :chan_board
    has_many :posts

    def update_posts
      replies = Fourchan::Kit::Thread.new(self.chan_board.board_id, self.op).posts
      replies.each do |r|
        if self.posts.where(post_num: r.no).empty?
          new_post(r)
        end
      end
    end

    private
    def new_post(r)

      text_minus_replies = r.com.gsub(/<a.*&gt;&gt;.*\/a>/, "") unless r.com.nil?
      cleaned = ActionView::Base.full_sanitizer.sanitize(r.com)#.gsub(/[[:punct:]]/, "")
      r.com.nil? ? cleaned = "" : nil
      @post = self.posts.new(
          chan_board_id: self.chan_board_id,
          text_hash: XXhash.xxh32(cleaned.downcase),
          post_num: r.no,
          poster_id: r.id,
          text: r.com.nil? ? "" : r.com,
          post_timestamp: r.time
        )
      @post.save
      @post.increment
    end
end
