#require('pg')
require_relative('../db/sql_runner')

class Album
  attr_reader(:id, :name, :artist_id)
  
  def initialize(options)
    @id=options['id']
    @name=options['name']
    @artist_id=options['artist_id']
  end

  def save()
    sql = " INSERT INTO albums (name, artist_id) VALUES ('#{name}','#{artist_id}') RETURNING *"
    # db=PG.connect({dbname: 'music_library', host: 'localhost'})
    # db.exec(sql)
    album_data = run_sql(sql)
    #db.close
    @id =album_data.first()['id'].to_i
    #db.close()
  end

  def artist()
    sql = "SELECT * FROM artists WHERE #{artist_id} = id;"
    artists_data = run_sql(sql)
    return artist = Artist.new(artists_data.first)
  end

  def self.all
    sql = "SELECT * FROM albums;"
    albums = run_sql(sql)
    result =albums.map{|album| Album.new(album)}
    #db.close
    return result
  end
end