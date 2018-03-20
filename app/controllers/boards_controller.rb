class BoardsController < ApplicationController
  def index
    @boards = Board.all
    render :index
  end

  def show
    @board = Board.find(params[:id]).board_id
    @posts = get_top_posts(params[:id])
  end
end
