require 'pry'
class PostsController < ApplicationController



  def show
    p params
    @board = ChanBoard.find(params[:chan_board_id])
    begin
      @posts = Post.where(text_hash: Post.find_by(post_num: params[:id]).text_hash)
    rescue
      @posts = nil
    end

    # begin
    #   @posts = Archive.where(text_hash: Archive.find_by(post_num: params[:id]).text_hash)
    # rescue
    #   @posts = nil
    # end

    @show_flags = !@posts.first.nat_flag.nil?
    @show_ids = !@posts.first.poster_id.nil?

    render :show
  end

  private

  def get_post
    @post = Post.where(id: params[:id])
  end

  def get_top_posts(board)
    top_hashes = PostCounter.order('occurrences DESC').limit(200)
    top_posts = []
    top_hashes.each do |h|
      top_posts << Post.where(text_hash: h.text_hash)
    end
    top_posts
  end


end
