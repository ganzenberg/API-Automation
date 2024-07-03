*** Settings ***
Library    RequestsLibrary
Library    Collections


*** Variables ***
${base_url}    https://reqres.in/


*** Test Cases ***
Post_user
    Create Session    mysession     ${base_url}
    ${body}=    Create Dictionary    name=ganesh   job=tester
    ${header}=    Create Dictionary    Content-Type=application/json
    ${response}=     Post Request     mysession    api/users    data=${body}    headers=${header}
   
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    
    #validations
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201
    
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    ganesh
    Should Contain    ${response_body}    tester
    
