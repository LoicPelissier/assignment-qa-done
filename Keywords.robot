*** Settings ***
Documentation     Petstore
...
...               Contains the keywords defined for Petstore automated tests 
...       
        
Library           SeleniumLibrary   timeout=120
Library		  Libraries/AdditionalSeleniumKeyword.py
Library		  Libraries/RestApi.py
Resource 	  ObjectRepository.robot

*** Keywords ***

DoD Set Small Screen
	Set Window Size  400  800

the user has accessed the webapp
	Open Petstore Page  Chrome

the page is rendered on the browser
	PetStore Page Should Be Displayed

the date of the day is displayed on the top right part of the page
	${X}=  Get Horizontal Position  ${DATE_LOCATOR}
	${Y}=  Get Vertical Position  ${DATE_LOCATOR}
	${EltW}  ${EltH}=  Get Element Size  ${DATE_LOCATOR}
	${WinW}  ${WinH}=  Get Window Size
	${IsTop}=  Evaluate  (${Y}+(${EltH}/2))<(${WinH}/2)
	${IsRight}=  Evaluate  (${X}+(${EltW}/2))>(${WinW}/2)
	Should Be True  ${IsTop}
	Should Be True  ${IsRight}

the date format is DD-MM-YYYY
	# Get Value
	${DATE_VALUE}=  Get Text  ${DATE_LOCATOR}  
	Should Match Regexp  ${DATE_VALUE}   ^\\d{2}\\-\\d{2}\\-\\d{4}$

the background color of the banner is black
	${BG_COLOR}=  Get Element Attribute  ${BANNER_LOCATOR}  bgcolor  
	${BG_COLOR}=  Execute Javascript  return window.getComputedStyle(document.evaluate('${BANNER_LOCATOR}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue,null).getPropertyValue("background-color");
	${IsBlack}=  Evaluate  '${BG_COLOR}'=='${BLACK}'
	Should be True  ${IsBlack}

Open PetStore Page
	[Arguments]    ${browser}
	Open Browser   ${URL}    browser=${browser}  #desired_capabilities=disable-extensions
	# Maximize Browser Window
	DoD Set Small Screen
	Set Selenium Speed    ${DELAY}
	Set Selenium Timeout  ${TIMEOUT}
 	PetStore Page Should Be Displayed

PetStore Page Should Be Displayed
	Wait Until Page Contains  ${PETSTORE_PAGE_IDENTIFIER}
	
Input Name
	[Arguments]  	${name}
	Input Text      ${PETNAME_LOCATOR}  			${name}

Input Status
	[Arguments]  	${status}
	Input Text      ${PETSTATUS_LOCATOR}  			${status}
	
Click Create
	Click Button   ${PETCREATE_BUTTON_LOCATOR}
	
Press Enter
	Press Key  		${PETCREATE_BUTTON_LOCATOR}  	\\13
	
Pet Should Exist In The List
	[Arguments]  ${name}  ${status}
	Page Should Contain Element  ${PET_LIST_ITEM_PFX}${name}${PET_LIST_ITEM_MID}${status}${PET_LIST_ITEM_SFX}

Pet Should Not Exist In The List
	[Arguments]  ${name}  ${status}
	Page Should Not Contain Element  ${PET_LIST_ITEM_PFX}${name}${PET_LIST_ITEM_MID}${status}${PET_LIST_ITEM_SFX}

Pet With Only Name Should Not Exist In The List
	[Arguments]  ${name}
	Page Should Not Contain Element  ${PET_LIST_ITEM_PFX}${name}${PET_LIST_ITEM_EMPTYSTATUS_SFX}

Pet With Only Status Should Not Exist In The List
	[Arguments]  ${status}
	Page Should Not Contain Element  ${PET_LIST_ITEM_EMPTYNAME_PFX}${status}${PET_LIST_ITEM_SFX}
	
Create Pet Without Status
	[Arguments]  	${name}
	PetStore Page Should Be Displayed
	Input Name  ${name}
	Click Create
	Pet With Only Name Should Not Exist In The List   ${name}
	
Create Pet Without Name
	[Arguments]  	${status}
	PetStore Page Should Be Displayed
	Input Status    ${status}	
	Click Create
	Pet With Only Status Should Not Exist In The List  ${status}
	
the user tries to add a new pet
	Empty Placeholder

Pet Name is mandatory
	Create Pet Without Name		US03TC01NT01 Status

Pet Status is mandatory
	Create Pet Without Status       US03TC01NT01 Name

Pet Name and Pet status are both mandatory fields
	Pet Name is mandatory
	Pet Status is mandatory

Input Pet Information
	[Arguments]  	${name}	   ${status}
	PetStore Page Should Be Displayed
	Input Name      ${name}
	Input Status    ${status}	
	
Create Pet Using Create Button
	[Arguments]  	${name}	   ${status}
	Input Pet Information	${name}	  ${status}
	Click Create
	Pet Should Exist In The List	${name}	  ${status}
	
Create Pet Using Enter Key
	[Arguments]  	${name}	   ${status}
	Input Pet Information	${name}	  ${status}
	Press Enter
	Pet Should Exist In The List	${name}	  ${status}
	
the user has entered Name and Status
	Empty Placeholder

the user is able to validate his input by using either keyboard Enter key or by clicking on the create button
	Create Pet Using Create Button  US03TC02PT01 Name  US03TC02PT01 Status
	Create Pet Using Enter Key      US03TC02PT02 Name  US03TC02PT02 Status

the user is able to validate his input by using keyboard Enter key
	Create Pet Using Create Button  US03TC02PT01 Name  US03TC02PT01 Status

the user is able to validate his input by clicking on the create button
	Create Pet Using Enter Key      US03TC02PT02 Name  US03TC02PT02 Status

the user has focused on the Pet Name field
	Set Focus To Element  ${PETNAME_LOCATOR}

Press TAB On Pet Name Field
	Press Key  ${PETNAME_LOCATOR}  \\9

Pet Status Field Should Have Focus
	Element Should Be Focused  ${PETSTATUS_LOCATOR}

Press TAB On Pet Status Field
	Press Key  ${PETSTATUS_LOCATOR}  \\9

Create Button Should Have Focus
	Element Should Be Focused  ${PETCREATE_BUTTON_LOCATOR}

the defined accessibility sequence should be respected when pressing the TAB key
	Press TAB On Pet Name Field
	Pet Status Field Should Have Focus
	Press TAB On Pet Status Field
	Create Button Should Have Focus

the user has focused on the Pet Status field
	Set Focus To Element  ${PETSTATUS_LOCATOR}

the user has pressed SHIFT + TAB
	# Press Key With Modifier  u'\ue008'  u'\ue004'
	Press Shift Tab

the focus should be on the Pet Name field
	Element Should Be Focused  ${PETNAME_LOCATOR}

the list of pets is displayed in a table like component
	Page Should Contain Element  ${PET_LIST_AS_TABLE_LOCATOR}

the list of pets is displayed
	the list of pets is displayed in a table like component

the user is able to view his pets name and status	
	Pet Should Exist In The List		Donald		Out of stock
	Pet Should Exist In The List		Pluto		Available
	Pet Should Exist In The List		Mickey		Available

a list of ${count} pets has been created in the webapp
	Create Json Db  ${count}

a list of ${expected_count} pets is loaded
	${actual_count}=  Execute Javascript  return document.evaluate('count(${PET_LIST_LINE_LOCATOR})',document,null,XPathResult.NUMBER_TYPE,null).numberValue;
	${correct_count_loaded}=  Evaluate  ${actual_count}==${expected_count}
	Should Be True  ${correct_count_loaded}

the page is loaded in less then ${expected_duration} seconds
# use the performance timing api, of course, it should be calculated several times and averaged to be accurate
	${actual_duration}=  Execute Javascript  return (window.performance.timing.loadEventEnd - window.performance.timing.navigationStart)/1000;
	${duration_is_ok}=  Evaluate  ${actual_duration}<=${expected_duration}
	Should Be True  ${duration_is_ok}

Click On Pet Name And Check It Is Editable
	[Arguments]  ${name}
#	Element Should Not Be Focused  ${EDITABLE_PETNAME_LOCATOR_PFX}${name}${PET_LIST_ITEM_SFX}
#	Click Element  ${NON_EDITABLE_PETNAME_LOCATOR_PFX}${name}${NON_EDITABLE_LIST_FIELD_PFX}
	Element Should Not Be Visible  ${EDITABLE_PETNAME_LOCATOR_PFX}${name}${PET_LIST_ITEM_SFX}
	Execute Javascript  document.evaluate('${NON_EDITABLE_PETNAME_LOCATOR_PFX}${name}${NON_EDITABLE_LIST_FIELD_PFX}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.click();
	Element Should Be Visible  ${EDITABLE_PETNAME_LOCATOR_PFX}${name}${PET_LIST_ITEM_SFX}

Click On Pet Status And Check It Is Editable
	[Arguments]  ${status}
#	Element Should Be Focused  ${EDITABLE_PETSTATUS_LOCATOR_PFX}${status}${PET_LIST_ITEM_SFX}
#	Click Element  ${EDITABLE_PETSTATUS_LOCATOR_PFX}${status}${NON_EDITABLE_LIST_FIELD_PFX}
	Element Should Not Be Visible  ${EDITABLE_PETSTATUS_LOCATOR_PFX}${status}${PET_LIST_ITEM_SFX}
	Execute Javascript  document.evaluate('${NON_EDITABLE_PETSTATUS_LOCATOR_PFX}${status}${NON_EDITABLE_LIST_FIELD_PFX}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.click();
	Element Should Be Visible  ${EDITABLE_PETSTATUS_LOCATOR_PFX}${status}${PET_LIST_ITEM_SFX}

the user can edit a pet by clicking on its name
	Click On Pet Name And Check It Is Editable      Mickey

the user can edit a pet by clicking on its status
	Click On Pet Status And Check It Is Editable    Out of stock

the user can edit a pet by clicking on its name or status
	the user can edit a pet by clicking on its name
	the user can edit a pet by clicking on its status
	
the user is editing a pet
	Empty Placeholder

Edit a Pet Name
	[Arguments]  ${old_name}  ${new_name}
	Execute Javascript  document.evaluate('${NON_EDITABLE_PETNAME_LOCATOR_PFX}${old_name}${NON_EDITABLE_LIST_FIELD_PFX}',document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue.click();
	Input Text  ${EDITABLE_PETNAME_LOCATOR_PFX}${old_name}${PET_LIST_ITEM_SFX}  ${new_name}

Edit a Pet Name Then Press Enter
	[Arguments]  ${old_name}  ${new_name}
	Edit a Pet Name  ${old_name}  ${new_name}
	Press Key  ${EDITABLE_PETNAME_LOCATOR_PFX}${old_name}${PET_LIST_ITEM_SFX}  \\13
	Page Should Contain Element  ${NON_EDITABLE_PETNAME_LOCATOR_PFX}${new_name}${NON_EDITABLE_LIST_FIELD_PFX}

Edit a Pet Name Then Press Escape
	[Arguments]  ${old_name}  ${new_name}
	Edit a Pet Name  ${old_name}  ${new_name}
	Press Key  ${EDITABLE_PETNAME_LOCATOR_PFX}${old_name}${PET_LIST_ITEM_SFX}  \\27
	Page Should Contain Element  ${NON_EDITABLE_PETNAME_LOCATOR_PFX}${old_name}${NON_EDITABLE_LIST_FIELD_PFX}

Edit a Pet Name Then Click Elsewhere
	[Arguments]  ${old_name}  ${new_name}
	Edit a Pet Name  ${old_name}  ${new_name}
	Click Element  ${PET_LIST_TITLE_LOCATOR}
	Page Should Contain Element  ${NON_EDITABLE_PETNAME_LOCATOR_PFX}${new_name}${NON_EDITABLE_LIST_FIELD_PFX}

the user can quit the editing by pressing Enter
	Edit a Pet Name Then Press Enter      Donald  Daffy

the user can quit the editing by pressing Escape
	Edit a Pet Name Then Press Escape     Pluto   Droopy

the user can quit the editing by clicking elsewhere
	Edit a Pet Name Then Click Elsewhere  Mickey  Jerry

the user has 3 ways to quit the editing
	the user can quit the editing by pressing Enter
	the user can quit the editing by pressing Escape
	the user can quit the editing by clicking elsewhere

Create Pet Trough REST API  
	[Arguments]  ${name}  ${status}
	${pet}=  Create Pet  ${name}  ${status}

Read Pet Through REST API
	[Arguments]  ${pet_id}  ${expected_name}
	&{pet}=  Read Pet  ${pet_id}
	${actual_name_match_expected}=  Evaluate  '&{pet}[name]'=='${expected_name}'
	Should Be True  ${actual_name_match_expected}

Read All Pets Through REST API
	${all_pets}=  Read All Pets
	Length Should Be  ${all_pets}  3

Update Pet Through REST API
	[Arguments]  ${pet_id}  ${new_name}  ${new_status}
	&{updated_pet}=  Update Pet  ${pet_id}  ${new_name}  ${new_status}
	${updated_name_match_parameters}=  Evaluate  '&{updated_pet}[name]'=='${new_name}' 
	${updated_status_match_parameter}=  Evaluate  '&{updated_pet}[status]'=='${new_status}'
	Should Be True  ${updated_name_match_parameters}
	Should Be True  ${updated_status_match_parameter}

Delete Pet Through REST API
	[Arguments]  ${pet_id}
	${res}=  Delete Pet  ${pet_id}

