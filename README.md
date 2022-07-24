## Install robot libraries
```sh
pip install robotframework-requests
pip install robotframework-excellib
pip install robotframework-jsonlibrary
```
Requirements to run browser tests need either chromedriver or geckodriver in path


## Execute Tests
Using robot command to execute tests from top level path/CassiniTestExercise
```sh
robot tests
```
For individual tests
```sh
robot tests/uitest.robot
robot tests/apitest.robot
```

## View Test Results
Results are currently output under path where robot was executed from.

Included sample test results, view by looking at report.html