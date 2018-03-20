class ChanBoard < ApplicationRecord
  has_many :chan_threads
  has_many :post_counters
  has_many :posts, through: :chan_threads

  def update_threads
    threads = Fourchan::Kit::Board.new(self.board_id).all_threads
    a = 1
    threads.each do |t|
      trd = Fourchan::Kit::Thread.new(self.board_id, t.no)

      @thread = ChanThread.find_by(op:t.no)
      if @thread.nil?
        @thread = ChanThread.new(board_id: self.board_id, op: t.no)
      end
      @thread.save

      @thread.update_posts(trd)
      a += 1
      break if a == 10
    end

    end
end
