class PostFetchingWorker
  #gets all currently active threads and catalogs the posts
  def get_posts(board)

    b = Fourchan::Kit::Board.new board
    threads = b.all_threads
    threads.each do |t|
      begin
        reps = Fourchan::Kit::Thread.new(board, t.no).fetch_replies
      rescue
        next
      end
      #The OP is not included when fetching replies - so add it to the list
      reps.insert(0, t)
      reps.each do |r|

        #skip if we're already watching this post
        next if Post.exists?(post_num: r.no)

        #roots out image only replies
        next if r.com.nil?

        #root out shitty one-word posts

        #remove all reply links.  This will leave all replies that are actually saying something
        text_minus_replies = r.com.gsub(/<a.*&gt;&gt;.*\/a>/, "")

        next if text_minus_replies == ""

        cleaned = ActionView::Base.full_sanitizer.sanitize(text_minus_replies).gsub(/[[:punct:]]/, "")

        @post = Post.new(
            text_hash: XXhash.xxh32(cleaned.downcase),
            board: board,
            op: r.resto != 0 ? r.resto : r.no,
            post_num: r.no,
            poster_id: r.id,
            text: r.com,
            post_timestamp: r.time
          )
        @post.save
        @post.increment
      end
    end

  end

end
