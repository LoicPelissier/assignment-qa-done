import urllib, urllib2, os, json

class CustomRequest(urllib2.Request):
    def __init__(self, *args, **kwargs):
        self._method = kwargs.pop('method', None)
        urllib2.Request.__init__(self, *args, **kwargs)
    def get_method(self):
        return self._method if self._method else super(CustomRequest, self).get_method()


def PutRequest(url, data):
    opener = urllib2.build_opener(urllib2.HTTPHandler)
    request = CustomRequest(url, method='PUT', data=data)
    return opener.open(request)


def DeleteRequest(url):
    opener = urllib2.build_opener(urllib2.HTTPHandler)
    request = CustomRequest(url, method='DELETE')
    return opener.open(request)


# get /pet/{petId}
# post /pet/{petId}
# delete /pet/{petId}
# get /pets
# post /pets

def ReadAllPets():
	print '*INFO* Calling GET /api/pets'
	response = urllib2.urlopen('http://localhost:3000/api/pets').read()
	print '*INFO* Got response '+response
	return json.loads(response)
	
def ReadPet(PetId):
	print '*INFO* Calling GET /api/pets/'+str(PetId)
	response = urllib2.urlopen('http://localhost:3000/api/pets/'+PetId).read()
	print '*INFO* Got response '+response
	return json.loads(response)

def CreatePet(PetName, PetStatus):
	print '*INFO* Calling POST /api/pets/ with parameters: name='+str(PetName)+" - status="+str(PetStatus)
	response = urllib2.urlopen('http://localhost:3000/api/pets', data=urllib.urlencode({ "name" : PetName, "status" : PetStatus })).read()
#json.dumps( { "id" : PetId, "name" : PetName, "status" : PetStatus } )).read()
	print '*INFO* Got response '+response
	return json.loads(response) #,encoding='ascii')
	
def UpdatePet(PetId, PetName, PetStatus):
	print '*INFO* Calling POST /api/pets/'+str(PetId)+' with parameters: name='+str(PetName)+" - status="+str(PetStatus)
	return json.loads(PutRequest('http://localhost:3000/api/pets/'+PetId, data=urllib.urlencode({ "name" : PetName, "status" : PetStatus })).read())
	
def DeletePet(PetId):
	print '*INFO* Colling DELETE /api/pets/'+str(PetId)
	return DeleteRequest('http://localhost:3000/api/pets/'+str(PetId)).read()
