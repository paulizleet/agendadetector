require 'pry'
class PostsController < ApplicationController
  def index
    @top_posts = get_top_posts("pol")
    render :index
  end

  def show
    p params

    @posts = Post.where(text_hash: Post.find_by(post_num: params[:id]).text_hash)
    render :show
  end


  private

  def get_post
    @post = Post.where(id: params[:id])
  end

  def get_top_posts(board)
    top_hashes = PostCounter.order('occurrences DESC').limit(50)
    top_posts = []
    top_hashes.each do |h|
      top_posts << Post.where(text_hash: h.text_hash)
    end
    top_posts
  end
end
