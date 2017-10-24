# assignment-qa-done

## Pre-requisite for execution

This assignement has been developped using:
- Python v2.7.12
- Selenium v3.6.0
- RobotFramework v3.0.2
- SeleniumLibrary v3.0.0b3

## Recommended folder layout

In order to be able to use the assignment as-is, it is recommended to clone both the assignment and this git project in the same folder:

<Any>---assignement-qa
      |
      |
 

## Execution
### Linux 

Go in the assignment-qa-done folder, then either execute the following command line:
```
python -m robot -d Executions/ Tests.robot
```
Or allow execution of LaunchRobot.sh file (```chmod +x```), and execute the script.

### Windows

The assignment has also been tested on Windows 7 using a custom jar containing Jython, Selenium, RobotFramework and Selenium2library. This can easily be demonstrated during the interview if needed.
