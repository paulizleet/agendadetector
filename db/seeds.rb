# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Get boards the old fashioned way without fancy gems

url = URI.parse('http://a.4cdn.org/boards.json')
request = Net::HTTP::Get.new(url.to_s)
response = Net::HTTP.start(url.host, url.port) {|http|
  http.request(request)
}

json = JSON.parse(response.body)

json["boards"].each do |board|
    ChanBoard.new(board_id: board["board"], board_name: board["title"]).save
end

json["troll_flags"].each_pair {|id,title| NatFlag.new(flag_id: id, flag_name: title, troll:true)}

# ChanBoard.new(board_id: 'his', board_name: 'History & Humanities').save
# ChanBoard.new(board_id: 'pol', board_name: 'Politically Incorrect').save
# ChanBoard.new(board_id: 'vg', board_name: 'Video Game Generals').save
# ChanBoard.new(board_id: 'v', board_name: 'Video Games').save
# ChanBoard.new(board_id: 'biz', board_name: 'Business & Finance').save
# ChanBoard.new(board_id: 'int', board_name: 'International').save


#add meme table so they aren't displayed in top posts
# memes = [
#
#   "q predicted this",
#   "not an argument",
#   "you have to go back",
#   "pretty much this",
#   "tits or gtfo"
#
# ]
#
# memes.each {|meme| Meme.new_meme(meme)}
