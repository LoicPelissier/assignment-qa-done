from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys

def PressKeyWithModifier(Key, Modifier):
	print '*INFO* Press key ['+Key+'] with ['+Modifier+'] modifier'
	ActionChains(BuiltIn().get_library_instance('SeleniumLibrary')._current_browser()).key_down(Modifier).send_keys(Key).key_up(Modifier).perform()

def PressShiftTab():
	ActionChains(BuiltIn().get_library_instance('SeleniumLibrary')._current_browser()).key_down(Keys.SHIFT).send_keys(Keys.TAB).key_up(Keys.SHIFT).perform()

def EmptyPlaceholder():
	pass
