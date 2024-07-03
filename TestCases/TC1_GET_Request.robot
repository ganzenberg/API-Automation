*** Settings ***
Library               RequestsLibrary
Library               Collections
*** Variables ***
${base_url}    https://reqres.in
${user_id}     2

*** Test Cases ***
Get_user_details
    Create Session      mysession       ${base_url}
    ${response}=  GET On Session     mysession   api/users/${user_id}
    
    #valdiation
    ${status_code}=    Convert To String     ${response.status_code}
    Should Be Equal    ${status_code}    200
    
    ${body}=        Convert To String    ${response.content}
    Should Contain    ${body}         Janet
    
    ${header_content}=     get from dictionary     ${response.headers}    Content-Type
    Should Contain      ${header_content}       application/json
    
    
