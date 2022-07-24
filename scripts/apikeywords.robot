*** Settings ****
Library     RequestsLibrary
Library     Collections
Library     ExcelLibrary.py
Library     JSONLibrary

*** Keywords    ***

I have navigated to reqres.in
    Log     Given I have navigated to reqres.in

I register with email and password
    [Arguments]     ${email}    ${password}
    
    &{data}=    Create dictionary  email=${email}  password=${password}
    ${resp}=    POST On Session    reqres  register  json=${data}  expected_status=any

I login with email and password
    [Arguments]     ${email}    ${password}
    
    &{data}=    Create dictionary  email=${email}  password=${password}
    ${resp}=    POST On Session    reqres  login  json=${data}  expected_status=any

I get list of resources
    Log     I get list of resources

Resource should contain id and name
    [Arguments]     ${expected_id}   ${expected_name}

    ${resp_data}=    GET On Session    reqres  unknown
    @{json_list}=       Create List

    FOR   ${key}   IN  @{resp_data.json()}[data]
        ${get_req_id}=  Set Variable    ${key['id']}
        ${get_req_name}=    Set Variable    ${key['name']}
        Log    ${get_req_id},${get_req_name}
        Append To List      ${json_list}    id=${get_req_id}        name=${get_req_name}
    END

    List Should Contain Value       ${json_list}     id=${expected_id}       name=${expected_name}
    Log     ${json_list}

I have an excel file with email and password
    Open Excel Document      filename=testdata/data.xlsx     doc_id=doc1
    
    ${excel_email}=      Read Excel Cell     row_num=1       col_num=1
    ${excel_password}=      Read Excel Cell     row_num=1       col_num=2

    Set Test Variable   ${email}        ${excel_email}
    Set Test Variable   ${password}     ${excel_password}
    