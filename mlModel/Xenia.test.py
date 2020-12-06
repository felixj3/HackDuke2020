from Xenia import *


conn = create_connection('db/development.sqlite3')

sbert_model = InitBert()
gmaps = InitGMapAPI()


InsertInstance(conn, 1, 2, 4, sbert_model, gmaps)


pass
