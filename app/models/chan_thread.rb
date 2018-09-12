class ChanThread < ApplicationRecord
    belongs_to :chan_board
    has_many :posts

    def update_posts
      replies = Fourchan::Kit::Thread.new(self.chan_board.board_id, self.op).posts
      replies.each do |r|
        next if r.com.nil?
        if self.posts.where(post_num: r.no).empty?
          new_post(r)
        end
      end
    end

    def archive
      @arc = ArchiveThread.new(chan_board_id: self.chan_board_id, op: self.op)
      self.posts.each do |post|
        begin
          post.decrement
          @arc.new_post(post)
          post.destroy
        rescue
          nil
        end
      end
      self.destroy
      @arc.save
    end

    private
    def new_post(r)

      r.com.nil? ? r.com = "" : nil
      text_minus_replies = r.com.gsub(/<a.*&gt;&gt;.*\/a>/, "") unless r.com.nil?

      cleaned = ActionView::Base.full_sanitizer.sanitize(r.com).gsub(/[[:punct:]]/, "")
      cleaned.unicode_normalize!(:nfkc) #decomposes and recomposes unicode characters to single code points to eliminate homoglyphs as much as possible

      @post = self.posts.new(
          chan_board_id: self.chan_board_id,
          text_hash: XXhash.xxh32(cleaned.downcase), #only use the normalized version for hashing purposes
          post_num: r.no,
          poster_id: r.id,
          nat_flag: get_flag(r),
          text: r.com,
          post_timestamp: r.time
        )
      @post.save
      @post.increment
    end

    def get_flag(r)
      return r.country if !r.country.nil?
      return "troll/#{r.troll_country}" if !r.troll_country.nil?
      nil
    end


end
