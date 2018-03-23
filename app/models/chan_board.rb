class ChanBoard < ApplicationRecord
  has_many :chan_threads
  has_many :post_counters
  has_many :posts, through: :chan_threads

  def update_threads
    threads = Fourchan::Kit::Board.new(board_id).all_threads

    threads.each do |t|
      @thread = self.chan_threads.find_by(op:t.no)
      if @thread.nil?
        @thread = self.chan_threads.new(op: t.no)
      end

      @thread.update_posts
      @thread.save
    end
  end

  def prune_threads
    board_id = ChanBoard.find(self.chan_board_id).board_id
    threads = Fourchan::Kit::Board.new(board_id).all_threads
    tracked_threads = {}
    self.chan_threads.each do |t|
      tracked_threads.merge(t.op => false)
    end
    threads.each do |t|
      tracked_threads[t.no.to_s] = true
    end

    tracked_threads.each_pair do |k, v|
      next if v
      self.chan_threads.find_by(op: k).posts.each do |post|
          post.decrement
          post.archive
      end
      self.chan_threads.find_by(op: k).destroy
    end
  end
end
