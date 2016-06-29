require('pg')

def run_sql( sql )
  begin
    db = PG.connect({dbname: 'music_library', host: 'localhost'})
    result = db.exec( sql )
  ensure #ensure that that command is executed doesn't matter if the previous lines are not.
    db.close
  end
  return result
end