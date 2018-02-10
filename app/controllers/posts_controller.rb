class PostsController < ApplicationController
  def index
    top_hashes = PostCounter.order('occurrences DESC').limit(20)
    @top_posts = []
    top_hashes.each do |h|
      @top_posts << Post.where(text_hash: h.text_hash)
    end

    render :index
  end

  def show
      @posts = Post.where(post_num: params[:id])
  end


  def new_threads
    get_threads("pol")
    redirect_to '/'
  end

  def purge
    purge_old_posts("pol")
  end

  private
  def purge_old_posts(board)
    tracked_threads = {}
    Posts.select(:op).distinct.where(board: board).each{|e| tracked_threads.merge!({e.op => false})}
    current_threads = Fourchan::Kit::Board(board).all_threads
    current_threads.each{ |t| tracked_threads[t.no] = true }
    tracked_threads.each_key do |k|
      next if tracked_threads[k]
      old_posts = Posts.where(op: tracked_threads[k])
      old_posts.each do |o|
        old_counter = PostCounter.find_by(text_hash: o.text_hash).destroy
        o.destroy
      end
    end
  end

  def get_threads(board)
    b = Fourchan::Kit::Board.new board
    puts "got board #{board}"
    threads = b.all_threads
    posts = b.all_posts
    puts "got posts"
    threads.each do |t|

      t.posts.each do |r|
        next if Post.exists?(post_num: r.no) && any_text?(r.com)
        @post = Post.new(
            text_hash: XXhash.xxh32(r.com),
            board: board,
            op: r.resto,
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

  def get_post
    @post = Post.where(id: params[:id])
  end

end
