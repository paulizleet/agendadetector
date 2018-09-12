class ArchivePostsController < ApplicationController

    def index
        @top_posts = get_top_archived_posts
        @board = ChanBoard.new(id: "Greatest Hits", board_id: "gh")
        render "chan_boards/show"
    end

    def show_board
        @board = ChanBoard.find(params[:id])
        @top_posts = get_top_archived_posts(@board)
        @greatest = true
        render "chan_boards/show"
    end

    private

    def get_top_archived_posts(board=nil)
        top_posts = []
        get_hashes(board).each do |h|
          top_posts << ArchivePost.where(text_hash: h.text_hash)
        end
        top_posts
    end

    def get_hashes(board)
        if board.nil?
            return ArchiveCounter.order('occurrences DESC').limit(200)
        else
            return ArchiveCounter.where(chan_board_id: board).order('occurrences DESC').limit(200)
        end

    end



end
