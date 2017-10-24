*** Settings ***
Documentation     Petstore Locators
...
...               Contains the locators used for Petstore automated tests 
...       
        
*** Variables ***

${DATE_LOCATOR}    xpath=//span[@class="banner-date"]/div
${BANNER_LOCATOR}  //div[@class="assignment-masthead"]

${PETSTORE_PAGE_IDENTIFIER}		Petstore webapp
${PETNAME_LOCATOR}			xpath=//div[@class="pet-app"]//input[contains(@class,"pet-name")]
${PETSTATUS_LOCATOR}			xpath=//div[@class="pet-app"]//input[contains(@class,"pet-status")]
${PETCREATE_BUTTON_LOCATOR}		xpath=//button[text()="Create"]

${PET_LIST_ITEM_PFX}  xpath=//span[contains(@class,"pet-name") and text()="
${PET_LIST_ITEM_MID}  "]//ancestor::tr[@class="pet-item"]//span[contains(@class,"pet-status") and text()="
${PET_LIST_ITEM_SFX}  "]

${PET_LIST_ITEM_EMPTYSTATUS_SFX}  "]//ancestor::tr[@class="pet-item"]//span[contains(@class,"pet-status") and string-length(text())=0]
${PET_LIST_ITEM_EMPTYNAME_PFX}    xpath=//span[contains(@class,"pet-name") and string-length(text())=0]//ancestor::tr[@class="pet-item"]//span[contains(@class,"pet-status") and text()="

${PET_LIST_LINE_LOCATOR}    	//h3[text()="List of Pets"]/parent::div/table/tbody/tr[@class="pet-item"]
${PET_LIST_AS_TABLE_LOCATOR}    xpath=${PET_LIST_LINE_LOCATOR}
	
${NON_EDITABLE_PETNAME_LOCATOR_PFX}  //tr[contains(@class,"pet-item")]/td/span[contains(@class,"pet-name") and text()="
${EDITABLE_PETNAME_LOCATOR_PFX}      xpath=//tr[contains(@class,"pet-item")]/td/input[contains(@class,"pet-name") and @value="

${NON_EDITABLE_PETSTATUS_LOCATOR_PFX}  //tr[contains(@class,"pet-item")]/td/span[contains(@class,"pet-status") and text()="
${EDITABLE_PETSTATUS_LOCATOR_PFX}      xpath=//tr[contains(@class,"pet-item")]/td/input[contains(@class,"pet-status") and @value="

${NON_EDITABLE_LIST_FIELD_PFX}   "]

${PET_LIST_TITLE_LOCATOR}  //h3[text()="List of Pets"]


