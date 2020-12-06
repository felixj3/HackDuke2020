from Xenia import *


conn = create_connection('db/development.sqlite3')

sbert_model = InitBert()
gmaps = InitGMapAPI()


InsertInstance(conn, 2, 3, 4, sbert_model, gmaps)


pass
