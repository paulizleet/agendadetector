class MasterWorker

  def self.start_workers


    ChanBoard.all.each do |b|
      now = Time.now
      puts "Starting to update #{b.board_id} at #{now}"
      b.update_threads
      b.archive_threads
      puts "Finished updating #{b.board_id} at #{Time.now}\nDuration: #{Time.now - now}\n\nThere are currently #{Post.count} tracked posts"

     end



    #now = Time.now
    #puts "Pruning Posts at #{now}"
    #ThreadPruningWorker.new.prune_posts(board)
    #puts "Finished pruning post at #{Time.now}\nDuration: #{Time.now - now}\n\nThere are currently #{Post.count} tracked posts"

  end

end
