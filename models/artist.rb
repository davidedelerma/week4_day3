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

  def self.find(id)
    sql="SELECT * FROM artists WHERE id=#{id};"
    artist = run_sql(sql)
    result = Artist.new(artist.first)
    return result
  end

  def self.all
    sql = "SELECT * FROM artists;"
    artists = run_sql(sql)
    result =artists.map{|artist| Artist.new(artist)}
    #db.close
    return result
  end

  def self.update(options)
    sql = "UPDATE artists SET 
          name = '#{options['name']}',
          WHERE id = '#{options['id']}';"
    run_sql(sql)
  end

  def self.destroy(id)
    sql="DELETE FROM artists WHERE id=#{id};"
    run_sql(sql)
  end

end

