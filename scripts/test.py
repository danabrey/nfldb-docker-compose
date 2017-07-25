#!python
import nfldb
db = nfldb.connect()

q = nfldb.Query(db)
q.game(season_year=2016, season_type='Regular', week=16, team='SEA')
drives = q.drive(pos_team='SEA').sort(('start_time', 'asc')).as_drives()
for d in drives:
    print d
