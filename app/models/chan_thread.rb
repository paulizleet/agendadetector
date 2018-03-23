class ChanThread < ApplicationRecord
    belongs_to :chan_board
    has_many :posts

    def update_posts
      replies = Fourchan::Kit::Thread.new(self.chan_board.board_id, self.op).posts
      replies.each do |r|
        p r
        p self.posts.where(post_num: r.no).empty?

        if self.posts.where(post_num: r.no).empty?
          new_post(r)
        end
      end

    end
    private
    def new_post(r)
      p r
      text_minus_replies = r.com.gsub(/<a.*&gt;&gt;.*\/a>/, "") unless r.com.nil?
      # return if text_minus_replies == ""

      cleaned = ActionView::Base.full_sanitizer.sanitize(r.com)#.gsub(/[[:punct:]]/, "")
      r.com.nil? ? cleaned = "" : nil
      @post = self.posts.new(
          text_hash: XXhash.xxh32(cleaned.downcase),
          post_num: r.no,
          poster_id: r.id,
          text: r.com.nil? ? "" : r.com,
          post_timestamp: r.time
        )
      @post.save
      puts "post saved"
      @post.increment
    end
end
