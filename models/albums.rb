#require('pg')
require('pry-byebug')
require_relative('../db/sql_runner')

class Album
  attr_reader(:id, :name, :artist_id, :year)
  
  def initialize(options)
    @id=options['id']
    @name=options['name']
    @year=options['year']
    @artist_id=options['artist_id']
  end

  def save()
    sql = " INSERT INTO albums (name, year,artist_id) VALUES ('#{name}','#{year}','#{artist_id}') RETURNING *"
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

  def self.find(id)
    sql="SELECT * FROM albums WHERE id=#{id};"
    album = run_sql(sql)
    result = Album.new(album.first)
    return result
  end

  def self.all
    sql = "SELECT * FROM albums;"
    albums = run_sql(sql)
    result =albums.map{|album| Album.new(album)}
    #db.close
    return result
  end

  def self.update(options)
    name = options['name']
    year = options['year']
    artist_id = options['artist_id']
    id = options['id']

    sql = "UPDATE albums SET 
          name = '#{name}',
          year = '#{year}',
          artist_id = '#{artist_id}'
          WHERE id = '#{id}';"
    # binding.pry
    run_sql(sql)
  end

  def self.destroy(id)
    sql="DELETE FROM albums WHERE id=#{id};"
    run_sql(sql)
  end


end


"UPDATE albums SET name = 'appetite', year = '1998',     artist_id = '2',WHERE id = '1';"