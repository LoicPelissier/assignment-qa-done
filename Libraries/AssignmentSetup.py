import shutil, json, time, os

def RestoreJsonDb():
	print '*INFO* Restoring Json Db'
	print '*INFO* Working dir :'+os.getcwd()
	shutil.copy('./Backup/db.json','../assignment-qa-master/src/server/')
	time.sleep(0.5)
	fd=open('../assignment-qa-master/src/server/db.json','r')
	print '*INFO* DB Content: ' + fd.read()
	fd.close()

def CreateJsonDb(RecordCount):
	print '*INFO* Creating '+RecordCount+' records'
	Data = { "pets" : [ ] }
	Zf = len(RecordCount)
	for Idx in range(1,int(RecordCount)+1):
		print '*INFO* Creating line '+str(Idx)
		Data["pets"].append( { "id" : Idx, "name" : "NAME"+str(Idx).zfill(3), "status" : "STATUS"+str(Idx).zfill(3) } )
	fd=open("../assignment-qa-master/src/server/db.json","w")
	fd.write(json.dumps(Data))
	fd.close()
	time.sleep(0.5)

