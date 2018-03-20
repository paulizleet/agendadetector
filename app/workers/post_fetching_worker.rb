class PostFetchingWorker
  #gets all currently active threads and catalogs the posts
  def get_posts(board)

    b = Board.find_by(board_id:  board)
    b.update_threads
    update_threads(board, b.all_threads)

  end

  def update_threads(board, threads)
    a = 1
    threads.each do |t|
      @thread = ChanThread.find_by(board_id: board, op: t.no)
      if @thread.nil?
        @thread = ChanThread.new(board, t)
      else
        puts "thread exists"
      end

      @thread.update_posts
      @thread.save
      a+=1
      break if a==10
    end
  end

end
