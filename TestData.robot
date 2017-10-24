*** Settings ***
Documentation     Petstore Test data
...
...               Contains the data used for Petstore automated tests 
...       
        
*** Variables ***

##########################################################################
#
# Setup 
#
##########################################################################

${DELAY}                        0
${TIMEOUT}			120

##########################################################################
#
# Shared 
#
##########################################################################

${PORT}				8080
${URL}                       	http://localhost:${PORT}

##########################################################################
#
# API (Swagger definition)
#
##########################################################################

${API_CREATE}    POST /pets
${API_READ}      GET /pet/{petId}
${API_READ_ALL}  GET /pets
${API_UPDATE}    PUT /pet/{petId}
${API_DELETE}    DELETE /pet/{petId}



${BLACK}  rgb(51, 51, 51)

