*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    os
Library    JSONLibrary


*** Variables ***
${base_url}=    https://videogamedb.uk:443


*** Test Cases ***
Test_JSON
    Create Session    mysession    ${base_url}
    ${response}=    GET On Session   mysession    api/videogame 
    
    ${json_object}=     to json    ${response.content}

    #single data validation
    ${game_id}=    Get Value From Json    ${json_object}    $[0].name
    Log To Console    ${game_id[0]}

    