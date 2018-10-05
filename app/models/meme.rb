class Meme
  include MongoMapper::Document

  def self.new_meme(meme)
    @meme = Meme.new(text_hash: XXhash.xxh32(meme.downcase), text: meme)
    @meme.save
  end

end
