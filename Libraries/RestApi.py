import urllib, urllib2, os, json

# get /pet/{petId}
# post /pet/{petId}
# delete /pet/{petId}
# get /pets
# post /pets
class RestApi:	
	class CustomRequest(urllib2.Request):
	    def __init__(self, *args, **kwargs):
		self._method = kwargs.pop('method', None)
		urllib2.Request.__init__(self, *args, **kwargs)
	    def get_method(self):
		return self._method if self._method else super(CustomRequest, self).get_method()


	def _PutRequest(self,url, data):
	    opener = urllib2.build_opener(urllib2.HTTPHandler)
	    request = RestApi.CustomRequest(url, method='PUT', data=data)
	    return opener.open(request)


	def _DeleteRequest(self,url):
	    opener = urllib2.build_opener(urllib2.HTTPHandler)
	    request = RestApi.CustomRequest(url, method='DELETE')
	    return opener.open(request)

	def __init__(self, host="localhost", port=3000):
		self._Host = host
		self._Port = port

	def ReadAllPets(self):
		print '*INFO* Calling GET /api/pets'
		response = urllib2.urlopen('http://'+self._Host+':'+str(self._Port)+'/api/pets').read()
		print '*INFO* Got response '+response
		return json.loads(response)
	
	def ReadPet(self,PetId):
		print '*INFO* Calling GET /api/pets/'+str(PetId)
		response = urllib2.urlopen('http://'+self._Host+':'+str(self._Port)+'/api/pets/'+PetId).read()
		print '*INFO* Got response '+response
		return json.loads(response)

	def CreatePet(self,PetName, PetStatus):
		print '*INFO* Calling POST /api/pets/ with parameters: name='+str(PetName)+" - status="+str(PetStatus)
		response = urllib2.urlopen('http://'+self._Host+':'+str(self._Port)+'/api/pets', data=urllib.urlencode({ "name" : PetName, "status" : PetStatus })).read()
		print '*INFO* Got response '+response
		return json.loads(response) 
	
	def UpdatePet(self,PetId, PetName, PetStatus):
		print '*INFO* Calling POST /api/pets/'+str(PetId)+' with parameters: name='+str(PetName)+" - status="+str(PetStatus)
		response = self._PutRequest('http://'+self._Host+':'+str(self._Port)+'/api/pets/'+PetId, data=urllib.urlencode({ "name" : PetName, "status" : PetStatus })).read()
		print '*INFO* Got response '+response
		return json.loads(response)
	
	def DeletePet(self,PetId):
		print '*INFO* Calling DELETE /api/pets/'+str(PetId)
		response = self._DeleteRequest('http://'+self._Host+':'+str(self._Port)+'/api/pets/'+str(PetId)).read()
		print '*INFO* Got response '+response
		return json.loads(response)


