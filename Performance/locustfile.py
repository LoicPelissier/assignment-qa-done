from locust import HttpLocust, TaskSet
import random

def ReadAllPets(l):
	response = l.client.get('/api/pets')

def ReadPet(l):
	response = l.client.get('/api/pets/'+str(random.randint(1,TestBehavior.currentPetIndex)),name='/api/pets/[id]')

def CreatePet(l):
	currentIndex = TestBehavior.currentPetIndex
	TestBehavior.currentPetIndex = TestBehavior.currentPetIndex + 1
	response = l.client.post('/api/pets', data={ "name" : "PetName"+str(currentIndex), "status" : "PetStatus"+str(currentIndex) })

def UpdatePet(l):
	response = l.client.put('/api/pets/'+PetId, data={ "name" : PetName, "status" : PetStatus })

def DeletePet(l):
	response = l.client.delete('/api/pets/'+str(PetId))


class TestBehavior(TaskSet):
    currentPetIndex = 1
    tasks = { ReadAllPets:1 , ReadPet:5, CreatePet:1 }
    def on_start(self):
        pass


class PetStoreRestApi(HttpLocust):
    task_set = TestBehavior
    min_wait = 0
    max_wait = 0

