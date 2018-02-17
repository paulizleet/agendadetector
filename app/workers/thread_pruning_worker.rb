class ThreadPruningWorker


  def enqueue
    puts "--------------"
    puts "Queued thread pruner"
    puts "--------------"
  end

  def success
    puts "--------------"
    puts "Thread Pruner finished succesfully"
    puts "--------------"
  end

  def failure
    puts "--------------"
    puts "Thread Pruner failed"
    puts "--------------"
  end

  #removes threads and posts which are no longer active
  def prune_posts(board)
    tracked_threads = {}
    Post.select(:op).distinct.where(board: board).each{|e| tracked_threads.merge!({e.op => false})}
    current_threads = Fourchan::Kit::Board.new(board).all_threads
    current_threads.each{ |t| tracked_threads[t.no.to_s] = true }
    tracked_threads.each_key do |k|
      #binding.pry
      next if tracked_threads[k] == true
      old_posts = Post.where(op: k)
      old_posts.each do |o|
        old_counter = PostCounter.find_by(text_hash: o.text_hash)
        old_counter[:occurrences] -= 1
        old_counter[:occurrences] > 0 ? old_counter.save : old_counter.destroy
      end
      old_posts.destroy_all
    end
  end
  #handle_asynchronously :purge_old_posts

end
