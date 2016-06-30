require('sinatra')
require('sinatra/contrib/all') if development?
require('pry-byebug')
require_relative('./models/albums')
require_relative('./models/artist')

get '/album/new' do
  @artists = Artist.all()
  erb(:new_album)
end

get '/album/:id' do 
  @album=Album.find(params[:id])
  erb(:show_album)
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

get '/album/:id/edit' do
  @album = Album.find(params[:id])
  @artists = Artist.all()
  erb(:edit_album)
end

post '/album/:id' do
  @album = Album.update(params)
  redirect to("/album/#{params[:id]}")
end

post '/album/:id/delete' do 
  album.destroy( params[:id] )
  redirect to('/album')
end
