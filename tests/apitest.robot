*** Settings ****
Resource    ../scripts/apikeywords.robot

Suite Setup      Create Session      reqres      https://reqres.in/api      verify=true
Suite Teardown   Delete All Sessions

*** Test Cases  ***
REGISTER - SUCCESSFUL
    [Documentation]    A test to check reqres.in/register is successful
    [Tags]      API

    Given I have navigated to reqres.in
    When I register with email and password     eve.holt@reqres.in      pistol
    Then Status Should Be   200

REGISTER - UNSUCCESSFUL - check empty password
    [Documentation]    A test to check reqres.in/register fails on empty password
    [Tags]      API

    Given I have navigated to reqres.in
    When I register with email and password     sydney@fife     ${EMPTY}
    Then Status Should Be   400

REGISTER - UNSUCCESSFUL - check wrong password
    [Documentation]    A test to check reqres.in/register fails on empty password
    [Tags]      API

    Given I have navigated to reqres.in
    When I register with email and password     sydney@fife     password
    Then Status Should Be   400

LOGIN - SUCCESSFUL
    [Documentation]    A test to check reqres.in/login is successful
    [Tags]      API

    Given I have navigated to reqres.in
    When I login with email and password     eve.holt@reqres.in     cityslicka
    Then Status Should Be   200

LOGIN - UNSUCCESSFUL
    [Documentation]    A test to check reqres.in/login fails on empty password
    [Tags]      API

    Given I have navigated to reqres.in
    When I login with email and password     peter@klaven     ${EMPTY}
    Then Status Should Be   400

LIST - ASSERT RESOURCE - Positive
    [Documentation]    A test to check reqres.in/unknown returns list with provided id and name
    [Tags]      API

    Given I have navigated to reqres.in
    When I get list of resources
    Then Resource should contain id and name     1      cerulean

Read from Excel Test
    [Documentation]    A test to read excel to parse email and password to reqres.in/login
    [Tags]      API
    
    Given I have an excel file with email and password
    When I register with email and password     ${email}    ${password}
    Then Status Should Be   400