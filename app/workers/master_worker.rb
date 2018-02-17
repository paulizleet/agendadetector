class MasterWorker

  def start_workers(board)

    PostFetchingWorker.new.get_posts(board)
    GreatestHitsWorker.new.gather_top_100(board)
    ThreadPruningWorker.new.prune_posts(board)

  end

end
