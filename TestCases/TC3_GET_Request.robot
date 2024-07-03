

*** Settings ***
Library     RequestsLibrary
Library    Collections



*** Variables ***
${base_url}    https://reqres.in
${user_id}    2

*** Test Cases ***
get_user_details
    Create Session    mysession    ${base_url}
    ${response}=    GET On Session    mysession    api/users/${user_id}
    
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Log To Console    ${response.headers}
    
    #validation
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    2
    
    ${header_content}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Contain    ${header_content}    application/json
    
post_user_details
     Create Session    mysession    ${base_url}
     ${body}=    Create Dictionary    first_name=ganesh    last_name=tester
     ${header}=    Create Dictionary    Content-Type=application/json
     ${response}=    Post Request    mysession    api/users    data=${body}    headers=${header}
     
     Log To Console    ${response.status_code}
     Log To Console    ${response.content}
     Log To Console    ${response.headers}
     
     #validation
     ${status_code}=    Convert To String    ${response.status_code}
     Should Be Equal    ${status_code}    201
     
     ${response_body}=    Convert To String   ${response.content}
     Should Contain    ${response_body}    ganesh

     ${header_content}=    Get From Dictionary    ${response.headers}    Content-Type
     Should Contain    ${header_content}    application/json