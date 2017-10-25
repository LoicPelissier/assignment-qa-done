# assignment-qa-done

## Pre-requisite for execution

This assignement has been developped using:
- Python v2.7.12
- Selenium v3.6.0
- RobotFramework v3.0.2
- SeleniumLibrary v3.0.0b3

## Recommended folder layout

In order to be able to use the assignment as-is, it is recommended to clone both the assignment and this git project in the same folder:
```
Any Folder -┬- assignment-qa
            |
            └- assignment-qa-done
``` 
If this folder structure is not respected, you'll have to update the paths in the file
- Libraries/AssignmentSetup.py

## Execution
### Linux 

This assignment has been developed under Ubuntu 16.04 (LTS). The following instructions should work for most linux flavor (this has even been tested successfully on a rasberry pi 3 running Ubuntu MATE). 

Go in the assignment-qa-done folder, then either execute the following command line:
```
python -m robot -d Executions/ Tests.robot
```
Or allow execution of LaunchRobot.sh file (```chmod +x```), and execute the script.

### Windows

The assignment has also been tested on Windows 7 using a custom jar containing Jython, Selenium, RobotFramework and **Selenium2library**. This can easily be demonstrated during the interview if needed.

### Side note

The assignement can be run on previous versions of Robot and Seleniumlibrary (Selenium2library) but in that case, the library name should be changed in the file ```Keywords.robot```
Some features used in the assessment will not work as they are new features in seleniumlibrary (hence not existing in selenium2library):
- ```Set Focus To Element``` does not exist in the Selenium2library version that was used to test on Windows, hence breaking the test cases ```US03_TC03_Accessibility sequence check``` and ```US03_TC04_Accessibility sequence check```
