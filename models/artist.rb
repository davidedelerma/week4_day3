require_relative('../db/sql_runner')

class Artist
  attr_reader :name, :id
  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ('#{name}') RETURNING *"
    artist_data = run_sql(sql)
    #db.close
    @id =artist_data.first()['id'].to_i
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = #{@id} ;"
    albums_data = run_sql(sql)#we get an array of hashes from this
    return albums_array = albums_data.map {|album| Album.new(album)} #to convert to an array of objects
  end

  def self.all
    sql = "SELECT * FROM artists;"
    artists = run_sql(sql)
    result =artists.map{|artist| Artist.new(artist)}
    #db.close
    return result
  end
end

