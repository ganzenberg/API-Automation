*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}    https://videogamedb.uk:443

*** Test Cases ***
Post_Auth
    Create Session    mysession    ${baseurl}
    ${body}=    Create Dictionary    password=admin    username=admin
    ${header}=    Create Dictionary    Content-Type=application/json    accept=application/json
    ${auth_response}=    Post Request    mysession    /api/authenticate    data=${body}    headers=${header}
    
    Log To Console    ${auth_response.status_code}
    ${payload}=    Set Variable    ${auth_response.json()}    # this will be the data you got from the service, as a plain dictionary
    ${value}=      Set Variable    ${payload['token']}
    Log To Console    ${value}
    set Suite Variable    ${value}
    Log To Console    ${auth_value}


*** Test Cases ***
Post_new_game
    Create Session    mysession    ${baseurl}
    ${auth_value1}=    Get Variable Value    ${value}
    
    ${body}=    Create Dictionary    name=Grand Theft Auto VI    releaseDate=2016-04-23 23:59:59    reviewScore=95    category=Driving    rating=Mature
    ${header}=    Create Dictionary    Content-Type=application/json    accept=application/json
    ${response}=    POST On Session       mysession    /api/videogame    data=${body}    headers=${header}
    Log To Console    ${auth_value1}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

    #validation
    ${response_status}=   Convert To String    ${response.status_code}
    Should Be Equal    ${response_status}    201
    

    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response.content}    Grand Theft Auto V    95


Get_game_list
    Create Session    mysession    ${baseurl}
    ${auth_value}=    Get Variable Value    ${auth_token}
    ${response}=    GET On Session    mysession    /api/videogame
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Log To Console    ${auth_value}
    
    #validation
    ${response_status}=    Convert To String    ${response.status_code}
    Should Be Equal    ${response_status}    200
    
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    Grand Theft Auto III     Final Fantasy VII
    
Get_game_byid
    Create Session    mysession    ${baseurl}
    ${response}=    GET On Session    mysession    /api/videogame/10
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    
    #validation
    ${response_status}=    Convert To String    ${response.status_code}
    Should Be Equal    ${response_status}    200
    
    ${response_body}=    Convert To String    ${response.content}
    Should Contain    ${response_body}    Grand Theft Auto III
    
    

    
    
    
    