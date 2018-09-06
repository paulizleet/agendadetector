class ChanBoardsController < ApplicationController

  def index
    @boards = ChanBoard.all

    render :index
  end

  def show
    begin
      @board = ChanBoard.find(params["id"])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :index
    end
    @top_posts = get_top_posts(@board)

    render :show

  end

  private

  def get_top_posts(board)
    p board
    top_hashes = board.post_counters.order('occurrences DESC').limit(200)
    
    top_posts = []
    top_hashes.each do |h|
      top_hash = board.posts.where(text_hash: h.text_hash)
      next if top_hash.length <= 1

      top_posts << top_hash
    end

    top_posts.each {|e| e.each {|post| p post}}
    top_posts
  end


end
