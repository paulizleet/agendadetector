class ChanBoard < ApplicationRecord
  has_many :chan_threads
  has_many :archive_threads
  has_many :post_counters
  has_many :archive_counters
  has_many :posts, through: :chan_threads
  has_many :archive_posts, through: :archive_threads

  def update_threads
    threads = Fourchan::Kit::Board.new(board_id).all_threads

    threads.each do |t|
      begin
        @thread = self.chan_threads.find_by(op:t.no)
        if @thread.nil?
          @thread = self.chan_threads.new(op: t.no)
        end

        @thread.update_posts
        @thread.save
      rescue
        nil
      end
    end
  end

  def archive_threads

    threads = Fourchan::Kit::Board.new(board_id).all_threads
    tracked_threads = {}
    self.chan_threads.each do |t|
      tracked_threads.merge!(t.op => false)
    end
    p tracked_threads
    puts "#{tracked_threads.count} tracked threads"
    puts "#{threads.count} current threads"
    threads.each do |t|
      tracked_threads[t.no.to_s] = true
    end

    tracked_threads.each_pair do |k, v|
      next if v
      begin
        thread = self.chan_threads.find_by(op: k)
        thread.archive
        thread.destroy
      rescue
        puts "Thread #{k} already deleted"
      end

    end
  end
end
