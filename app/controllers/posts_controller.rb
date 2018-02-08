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
      @posts = Post.where(text_hash: params[:id])
  end


  def new_threads
    get_threads("pol")
    render :index
  end

  private
  def get_threads(board)
    b = Fourchan::Kit::Board.new board
    puts "got board #{board}"
    posts = b.all_posts
    puts "got posts"

    posts.each do |r|

      #p r.com
      @post = Post.find_by(post_num: r.no)
      cleaned = clean_post(r.com)
      next if cleaned.nil?
      if @post.nil?
          @post = Post.new(
            text_hash: XXhash.xxh32(cleaned),
            board: board,
            op: r.resto,
            post_num: r.no,
            poster_id: r.id,
            text: cleaned,
            post_timestamp: r.time
          )
          @post.save
        else
          p "not saving"
      end
      @post.increment



    end
  end

  def clean_post(text)
    #remove html formatting and shit
    text
  end

  def get_post
    @post = Post.where(id: params[:id])
  end

end
