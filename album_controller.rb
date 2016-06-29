require('sinatra')
require('sinatra/contrib/all') if development?
require('pry-byebug')
require_relative('./models/albums')

get '/album/new' do
  erb(:new_album)
end

post '/album' do 
  #create pizza object
  @album=Album.new(params)
  #save to database
  @album.save()
  erb(:create_album)
end

get '/album' do
  @albums = Album.all()
  #binding.pry
  erb(:index_album)
end