class ChanThread < ApplicationRecord
    belongs_to :chan_board
    has_many :posts

    def new(b, t)
      @thread = Thread.new

      @thread.op = t.no
      @thread.board_id = b

      new_post(b, t)
      @thread
    end

    def update_posts(thread)
      if !Post.exists?(post_num: thread.op.no)
        new_post(self.board_id, thread.op)
      end

      thread.replies.each do |r|
        #skip if we're already watching this post
        next if Post.exists?(post_num: r.no)
        new_post(self.board_id, r)
      end

    end
    private
    def new_post(b, r)
      # text_minus_replies = r.com.gsub(/<a.*&gt;&gt;.*\/a>/, "") unless r.com.nil?
      # return if text_minus_replies == ""

      cleaned = ActionView::Base.full_sanitizer.sanitize(r.com)#.gsub(/[[:punct:]]/, "")
      r.com.nil? ? cleaned = "" : nil
      @post = Post.new(
          text_hash: XXhash.xxh32(cleaned.downcase),
          #op: r.resto != 0 ? r.resto : r.no,
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
