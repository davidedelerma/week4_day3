require('sinatra')
require('sinatra/contrib/all') if development?
require('pry-byebug')
require_relative('./models/artist')
require_relative('./models/albums')
require_relative('./artist_controller')
require_relative('./album_controller')

get '/library' do
  #binding.pry
  erb(:library)
end