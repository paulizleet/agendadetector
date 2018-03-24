class ChanBoardsController < ApplicationController

  def index
    @boards = ChanBoard.all

    render :index
  end

  def show

    @board = ChanBoard.find(params["id"])
    @top_posts = get_top_posts(@board)

    render :show

  end

  private

  def get_top_posts(board)
    p board
    top_hashes = board.post_counters.order('occurrences DESC').limit(50)
    top_posts = []
    top_hashes.each do |h|
      top_posts << board.posts.where(text_hash: h.text_hash)
    end
    top_posts
  end
end
