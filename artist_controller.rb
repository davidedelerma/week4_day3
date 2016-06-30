require('sinatra')
require('sinatra/contrib/all') if development?
require('pry-byebug')
require_relative('./models/artist')

get '/artist/new' do
  erb(:new_artist)
end

get '/artist/:id' do 
  @artist=Artist.find(params[:id])
  erb(:show_artist)
end

post '/artist' do 
  #create pizza object
  @artist=Artist.new(params)
  #save to database
  @artist.save()
  erb(:create_artist)
end

get '/artist' do
  @artists = Artist.all()
  #binding.pry
  erb(:index_artist)
end

post '/artist/:id' do
  @artist = Artist.update(params)
  redirect to("/artist/#{params[:id]}")
end

post '/artist/:id/delete' do 
  Artist.destroy( params[:id] )
  redirect to('/artist')
end
