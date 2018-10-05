require 'pry'
class ChanBoard
  include MongoMapper::Document

  key :board_id, String
  key :board_name, String


  many :chan_threads
  many :archive_threads

  many :post_counters
  many :archive_counters

  many :posts, through: :chan_threads
  many :archive_posts, through: :archive_threads

  def update_threads
    threads = Fourchan::Kit::Board.new(board_id).all_threads

    #p threads[0]
    

    threads_to_add = []

     threads.each do |t|
        #@thread = self.thread_ids.find(op:t.no)
        @thread = ChanThread.find_or_create_by_board_id_and_op(self.board_id, t.no.to_s)
        @thread.update_posts
        @thread.save

    end


    #ChanThread.import(threads_to_add, options={recursive: true})

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
