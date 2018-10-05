class MasterWorker

  def self.start_workers

    beginning = Time.now
    ChanBoard.all.each do |b|
      now = Time.now
      b.update_threads
      b.archive_threads
      puts "Updated #{b.board_id} Duration: #{Time.now - now}\n\nThere are currently #{Post.count} tracked posts"

     end

     puts "Whole operation took #{Time.now-beginning}"



    #now = Time.now
    #puts "Pruning Posts at #{now}"
    #ThreadPruningWorker.new.prune_posts(board)
    #puts "Finished pruning post at #{Time.now}\nDuration: #{Time.now - now}\n\nThere are currently #{Post.count} tracked posts"

  end

end
