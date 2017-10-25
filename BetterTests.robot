*** Settings ***
Documentation     Petstore Regression
...
...               Contain the Petstore Regression test cases
...       
   
Library			Libraries/AssignmentSetup.py
     
Resource		Keywords.robot
Resource		TestData.robot

Test Setup       Restore Json Db
Test Teardown    Close Browser

*** Test Cases ***

US01_TC01a_Display the current date
	[Tags]  us01  display layout
	Given the user has accessed the webapp
	When the page is rendered on the browser
	Then the date of the day is displayed on the top right part of the page


US01_TC01b_Display the current date
	[Tags]  us01  display format
	Given the user has accessed the webapp
	When the page is rendered on the browser
	Then the date format is DD-MM-YYYY

US01_TC01c_Display the current date
	[Tags]  us01  display format
	Given the user has accessed the webapp
	When the page is rendered on the browser
	Then the background color of the banner is black

US02_TC01a_View the list of pets
	[Tags]  us02  read
	Given the user has accessed the webapp
	When the page is rendered on the browser
	Then the list of pets is displayed in a table like component

US02_TC01b_View the list of pets
	[Tags]  us02  read
	Given the user has accessed the webapp
	When the page is rendered on the browser
	Then the user is able to view his pets name and status	

US02_TC02_View a 100 pets list
	[Tags]  us02  read  volume  performance	
	Given a list of 100 pets has been created in the webapp
	And the user has accessed the webapp
	When the page is rendered on the browser
	And a list of 100 pets is loaded
	Then the list of pets is displayed in a table like component
	And the page is loaded in less then 2 seconds

US03_TC01a_Name is mandatory for creation
	[Tags]  us03  create
	Given the user has accessed the webapp
	When the page is rendered on the browser
	And the user tries to add a new pet
	Then Pet Name is mandatory

US03_TC01b_Status is mandatory for creation
	[Tags]  us03  create
	Given the user has accessed the webapp
	When the page is rendered on the browser
	And the user tries to add a new pet
	Then Pet Status is mandatory

US03_TC02a_Creation can be validated with button
	[Tags]  us03  create
	Given the user has accessed the webapp
	When the page is rendered on the browser
	And the user has entered Name and Status
	Then the user is able to validate his input by using keyboard Enter key

US03_TC02b_Creation can be validated with keyboard
	[Tags]  us03  create
	Given the user has accessed the webapp
	When the page is rendered on the browser
	And the user has entered Name and Status
	Then the user is able to validate his input by clicking on the create button

US03_TC03_Accessibility sequence check
	[Tags]  us03  accessibility
	Given the user has accessed the webapp
	When the page is rendered on the browser
	And the user has focused on the Pet Name field
	Then the defined accessibility sequence should be respected when pressing the TAB key

US03_TC04_Accessibility sequence check
	[Tags]  us03  accessibility
	Given the user has accessed the webapp
	When the page is rendered on the browser
	And the user has focused on the Pet Status field
	And the user has pressed SHIFT + TAB
	Then the focus should be on the Pet Name field

US04_TC01a_Modify a pet name
	[Tags]  us04  update
	Given the user has accessed the webapp
	When the page is rendered on the browser
	And the list of pets is displayed
	Then the user can edit a pet by clicking on its name

US04_TC01b_Modify a pet status
	[Tags]  us04  update
	Given the user has accessed the webapp
	When the page is rendered on the browser
	And the list of pets is displayed
	Then the user can edit a pet by clicking on its status

US04_TC02a_Modify a pet and quit editing
	[Tags]  us04  update
	Given the user has accessed the webapp
	When the page is rendered on the browser
	And the list of pets is displayed
	And the user is editing a pet
	Then the user can quit the editing by pressing Enter

US04_TC02b_Modify a pet and quit editing
	[Tags]  us04  update
	Given the user has accessed the webapp
	When the page is rendered on the browser
	And the list of pets is displayed
	And the user is editing a pet
	Then the user can quit the editing by pressing Escape

US04_TC02c_Modify a pet and quit editing
	[Tags]  us04  update
	Given the user has accessed the webapp
	When the page is rendered on the browser
	And the list of pets is displayed
	And the user is editing a pet
	Then the user can quit the editing by clicking elsewhere

US05_TC01a_Expose a REST API
	[Tags]  us05  rest  api  crud
	Read All Pets Through REST API

US05_TC01b_Expose a REST API
	[Tags]  us05  rest  api  crud
	Create Pet Trough REST API  US05TC01 Name  US05TC01 Status
	Open Petstore Page  Chrome
	Pet Should Exist In The List  US05TC01 Name  US05TC01 Status

US05_TC01c_Expose a REST API
	[Tags]  us05  rest  api  crud
	Read Pet Through REST API  1  Donald

US05_TC01d_Expose a REST API
	[Tags]  us05  rest  api  crud
	Update Pet Through REST API  1  Daffy  Available
	Open Petstore Page  Chrome
	Pet Should Exist In The List  Daffy  Available

US05_TC01e_Expose a REST API
	[Tags]  us05  rest  api  crud
	# Pluto is id 2 
	Delete Pet Through REST API  2
	Open Petstore Page  Chrome
	Pet Should Not Exist In The List  Pluto  Available


