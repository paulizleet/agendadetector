require 'pry'
class PostsController < ApplicationController
  def index
    @top_posts = get_top_posts("pol")

    render :index
  end

  def show
      @posts = Post.where(post_num: params[:id])
  end

  def new_threads
    @asdf = PostFetchingWorker.new.perform_without_delay("pol")
    @top_posts = get_top_posts("pol")

    render :index
  end

  def prune
    ThreadMaintainanceWorker.new.purge_old_posts("pol")
    redirect_to '/'
  end

  private

  def get_post
    @post = Post.where(id: params[:id])
  end

  def get_top_posts(board)
    top_hashes = PostCounter.order('occurrences DESC').limit(20)
    top_posts = []
    top_hashes.each do |h|
      top_posts << Post.where(text_hash: h.text_hash)
    end
    top_posts
  end
end
