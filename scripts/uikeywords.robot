*** Settings ****
Library     SeleniumLibrary
Library     Collections
Library     ExcelLibrary.py

Variables	yahooPageObjects.yaml

*** Keywords    ***
Accept Cookies
    Wait Until Page Contains Element   ${yahoo.cookies.acceptButton}
    Click Element   ${yahoo.cookies.acceptButton}

Navigate To Sign In Page
    Wait Until Element Is Visible   ${yahoo.home.signIn}
    Click Element                   ${yahoo.home.signIn}

Enter Username And Sign In
    [Arguments]     ${username}
    
    Wait Until Element Is Visible       ${yahoo.login.signIn}       1s
    Input Text                          ${yahoo.login.username}     ${username}
    Click Element                       ${yahoo.login.signIn}

Enter Password And Sign In
    [Arguments]     ${password}
    
    Wait Until Element Is Visible       ${yahoo.login.password}     1s
    Input Text                          ${yahoo.login.password}     ${password}
    Click Element                       ${yahoo.login.signIn}

Sign Out From Yahoo Home
    Wait Until Element Is Visible   ${yahoo.home.account}       1s
    Mouse Over                      ${yahoo.home.account}
    Wait Until Element Is Visible   ${yahoo.home.signOut}       1s
    Click Element                   ${yahoo.home.signOut}

Navigate To Finance Page
    Wait Until Element Is Visible   ${yahoo.home.financePage}       1s
    Click Element                   ${yahoo.home.financePage}

Navigate To Calendar
    Wait Until Element Is Visible   ${yahoo.finance.navbar.marketData}      1s
    Mouse Over                      ${yahoo.finance.navbar.marketData}
    Wait Until Element Is Visible   ${yahoo.finance.navbar.marketDataCalendar}      1s
    Click Element                   ${yahoo.finance.navbar.marketDataCalendar}

Set Event Date In Date Picker
    [Arguments]     ${date}
    
    Wait Until Element Is Visible   ${yahoo.finance.calendar.eventDateTitle}     1s
    Click Element                   ${yahoo.finance.calendar.dateRange}
    ${status}=  Is Element Visible  ${yahoo.finance.calendar.datePicker}
    Run Keyword If  '${status}'=='False'    Click Element                   ${yahoo.finance.calendar.dateRange}
    Wait Until Element Is Visible   ${yahoo.finance.calendar.datePicker}    1s
    Input Text                      ${yahoo.finance.calendar.datePicker}    ${date}
    Click Element                   ${yahoo.finance.calendar.dateApply}
    Wait Until Element Is Visible   ${yahoo.finance.calendar.eventDateTitle}     1s

Is Element Visible
	[Arguments]	${element}
	
    ${status}=	Run Keyword And Return Status	Element Should Be Visible	${element}
	[Return]	${status}

Value For Earnings Should Be
    [Arguments]     ${value}

    ${expectedValue}=   Catenate    ${value}    Earnings
    ${response}     Get Text    ${yahoo.finance.calendar.eventDateEarnings}
    Should Be Equal As Strings      ${response}     ${expectedValue}

Value For Stock Splits Should Be
    [Arguments]     ${value}

    ${expectedValue}=   Catenate    ${value}    Stock splits
    ${response}     Get Text    ${yahoo.finance.calendar.eventDateSplits}
    Should Be Equal As Strings      ${response}     ${expectedValue}

Value For IPO Pricing Should Be
    [Arguments]     ${value}

    ${expectedValue}=   Catenate    ${value}    IPO pricing
    ${response}     Get Text    ${yahoo.finance.calendar.eventDatePricing}
    Should Be Equal As Strings      ${response}     ${expectedValue}

Value For Economic Events Should Be
    [Arguments]     ${value}

    ${expectedValue}=   Catenate    ${value}    Economic events
    ${response}     Get Text    ${yahoo.finance.calendar.eventDateEvents}
    Should Be Equal As Strings      ${response}     ${expectedValue}
    