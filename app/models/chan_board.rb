class ChanBoard < ApplicationRecord
  has_many :chan_threads
  has_many :post_counters
  #has_many :posts, through: :chan_threads

  def update_threads
    threads = Fourchan::Kit::Board.new(self.board_id).all_threads
    a = 1
    threads.each do |t|
      @thread = self.chan_threads.find_by(op:t.no)
      if @thread.nil?
        @thread = self.chan_threads.new(op: t.no)
      end

      @thread.update_posts
      @thread.save
      a += 1
      break if a == 10
    end

    end
end
