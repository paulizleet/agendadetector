require 'pry'
class PostsController < ApplicationController

  def greatest
    @board = "pol"
    @top_posts = get_top_archived_posts(@board)
    render :index
  end

  def index
    @board = "pol"
    @top_posts = get_top_posts(@board)
    render :index
  end

  def show
    p params
    begin
      @posts = Post.where(text_hash: Post.find_by(post_num: params[:id]).text_hash)
    rescue
      @posts = nil
    end
    begin
      @archived = Archive.where(text_hash: Archive.find_by(post_num: params[:id]).text_hash)
    rescue
      @archived = nil
    end
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

  def get_top_archived_posts(board)
    top_hashes = ArchiveCounter.order('occurrences DESC').limit(200)
    top_hashes.each { |r| p r}
    top_posts = []
    top_hashes.each do |h|
      top_posts << Archive.where(text_hash: h.text_hash)
    end
    top_posts
  end
end
