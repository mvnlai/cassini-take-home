*** Settings ****
Library     SeleniumLibrary

Suite Setup     Open Browser    https://yahoo.com/      firefox
Test Setup      Accept Cookies
Test Teardown   Navigate to Yahoo and Clear Cookies
Suite Teardown  Close All Browsers

Resource    ../scripts/uikeywords.robot

*** Test Cases  ***
Login Test With Users
    [Documentation]    Use excel data for username and password
    [Tags]      UI

    ${usernameData}=    List Username Data
    ${passwordData}=    List Password Data

    ${status}=  Is Element Visible   ${yahoo.home.signIn}
    Run Keyword If  '${status}'=='True'     Navigate To Sign In Page
    Enter Username And Sign In      ${usernameData}[1]
    
    ${status}=  Is Element Visible   ${yahoo.login.usernameError}
    Run Keyword If  '${status}'=='True'     Fail    Username Invalid
    Enter Password And Sign In      ${passwordData}[1]

    ${status}=  Is Element Visible   ${yahoo.home.signIn}
    Run Keyword If  '${status}'=='False'     Sign Out From Yahoo Home

Event Calendar Test
    [Documentation]    
    [Tags]      UI

    Navigate To Finance Page
    Navigate To Calendar
    Set Event Date In Date Picker   07/12/2022
    Sleep   2s
    Value For Earnings Should Be  6
    Value For Stock Splits Should Be  25
    Value For IPO Pricing Should Be  5
    Value For Economic Events Should Be  7

*** Keywords ***
List Username Data
    ${usernameList}=    Create List

    Open Excel Document   filename=testdata/credentials.xlsx  doc_id=Sheet1
    
    FOR   ${i}   IN RANGE    1    5
        ${username}=  Read Excel Cell   row_num=${i}    col_num=1
        Log to Console  ${username} 
        Append To List      ${usernameList}      ${username}
    END
    [Return]    ${usernameList}

List Password Data
    ${passwordList}=    Create List
    
    FOR   ${i}   IN RANGE    1    5
        ${password}=  Read Excel Cell   row_num=${i}    col_num=2
        Log to Console  ${password}
        Append To List      ${passwordList}     ${password}  
    END
    [Return]    ${passwordList}

Navigate to Yahoo and Clear Cookies
    Delete All Cookies
    Go To   https://yahoo.com/