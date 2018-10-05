class PostCounter
  include MongoMapper::Document

  key :occurrences

  belongs_to :chan_board
end
