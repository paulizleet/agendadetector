class PostFetchingWorker
  def enqueue
    puts "--------------"
    puts "Queued post fetcher"
    puts "--------------"
  end
  def before
    puts "--------------"
    puts "beginning post fetcher"
    puts "--------------"
  end

  def success
    puts "--------------"
    puts "Post fetcher finished succesfully"
    puts "--------------"
  end

  def failure
    puts "--------------"
    puts "post fetcher failed"
    puts "--------------"
  end

  #gets all currently active threads and catalogs the posts
  def perform(board)
    puts "Fetching Posts"
    b = Fourchan::Kit::Board.new board
    threads = b.threads(1)
    threads.each do |t|

      begin
        reps = Fourchan::Kit::Thread.new(board, t.no).fetch_replies
      rescue
        next
      end
      #The OP is not included when fetching replies - so add it to the list
      reps.insert(0, t)
      reps.each do |r|
        next if Post.exists?(post_num: r.no) && any_text?(r.com)
        @post = Post.new(
            text_hash: XXhash.xxh32(r.com),
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
  handle_asynchronously :perform


  private
  def any_text?(text)
    return false if text.nil?
    #test to see if it's just a (you)
    stripped = text.strip
    stack = []
    i=0
    while i < stripped.length
      i+=1
      case stripped[i]
      when "<"
        stack.push(true)
      when ">"
        stack.pop
      else
        nil
      end
      return true if i > stripped.length
    end
    false
  end

end
