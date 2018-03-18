# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Board.new(board_id: 'his', board_name: 'History & Humanities')
Board.new(board_id: 'pol', board_name: 'Politically Incorrect')
Board.new(board_id: 'vg', board_name: 'Video Game Generals')
Board.new(board_id: 'v', board_name: 'Video Games')


#add meme table so they aren't displayed in top posts
memes = [

  "q predicted this",
  "not an argument",
  "you have to go back",
  "pretty much this",
  "tits or gtfo"

]

memes.each {|meme| Meme.new_meme(meme)}
