class MasterWorker

  def start_workers

    now = Time.now
    puts "Fetching Posts at #{now}"
    ChanBoard.all.each {|b| b.update_threads}
    puts "Finished fetching post at #{Time.now}\nDuration: #{Time.now - now}\n\nThere are currently #{Post.count} tracked posts"


    GreatestHitsWorker.new.gather_top_100(board)

    #now = Time.now
    #puts "Pruning Posts at #{now}"
    #ThreadPruningWorker.new.prune_posts(board)
    #puts "Finished pruning post at #{Time.now}\nDuration: #{Time.now - now}\n\nThere are currently #{Post.count} tracked posts"

  end

end
