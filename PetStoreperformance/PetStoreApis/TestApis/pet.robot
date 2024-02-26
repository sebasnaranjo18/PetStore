*** Settings ***
Library                             JSONLibrary
Library                             Collections
Library                             SeleniumLibrary
Library                             RequestsLibrary
Library                             xml

Resource                            ../Resources/resources.robot
Resource                            ../images/Mia.jpg
Resource                            ../Robot_Resources/perftest.resource

*** Variables ***



*** Test Cases ***
Scenario: User Executes a Post Request to Add a Pet
        [Documentation]                  Post Request add pet

        create session                   API_Testing_Post                    https://petstore3.swagger.io/api/v3
        ${header}=                       create dictionary                   Content-Type=application/xml                accept=application/xml
        ${xml}=                          set variable                        <pet><id>10</id><name>doggie</name><category><id>1</id><name>Dogs</name></category><photoUrls><photoUrl>string</photoUrl></photoUrls><tags><tag><id>0</id><name>string</name></tag></tags><status>available</status></pet>
        ${response}=                     POST On Session                     API_Testing_Post             /pet          data=${xml}    headers=${header}
        log to console                   ${response.status_code}
        #validations
        ${code}                          convert to string                   ${response.status_code}
        should be equal                  ${code}                             200

Scenario: User Executes a Put Request to Update a Pet
        [Documentation]                  Put Request update pet

        create session                  API_Testing_Post                     https://petstore3.swagger.io/api/v3
        ${header}=                      create dictionary                    Content-Type=application/xml                accept=application/xml
        ${xml}=                         set variable                         <pet><id>10</id><name>MiaMarcela</name><category><id>1</id><name>criollo</name></category><photoUrls><photoUrl>string</photoUrl></photoUrls><tags><tag><id>0</id><name>string</name></tag></tags><status>available</status></pet>
        ${response}=                    PUT On Session                       API_Testing_Post             /pet          data=${xml}    headers=${header}
        log to console                  ${response.status_code}
        #validations
        ${code}                          convert to string                   ${response.status_code}
        should be equal                  ${code}                             200

Scenario: The User Executes a Get Request to Obtain Information About a Pet According to Its Tag
        [Documentation]                  Get Request searching pet by tag

        ${header}=                       create dictionary                  Content-Type=application/xml
        create session                   API_Testing                        https://petstore3.swagger.io/api/v3
        ${Get_Response}=                 GET On Session                     API_Testing                                     url=/pet/findByTags?tags=string      headers=${header}
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario: The User Executes a Get Request to Obtain Information About a Pet According to Its Status
        [Documentation]                  Get Request searching pet by status

        ${header}=                       create dictionary                  Content-Type=application/xml
        create session                   API_Testing                        https://petstore3.swagger.io/api/v3
        ${Get_Response}=                 GET On Session                     API_Testing                                     url=/pet/findByStatus?status=available      headers=${header}
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario: The User Executes a Get Request to Obtain Information About a Pet According to Its ID
        [Documentation]                  Get Request searching pet by id

        ${header}=                       create dictionary                  Content-Type=application/xml
        create session                   API_Testing                        https://petstore3.swagger.io/api/v3
        ${Get_Response}=                 GET On Session                     API_Testing                                     url=/pet/10      headers=${header}
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario: User Executes a Delete Request to Delete a Pet
        [Documentation]                  Delete Request pet

        ${header}=                       create dictionary                  Content-Type=application/json
        create session                   API_Testing                        https://petstore3.swagger.io/api/v3
        ${Get_Response}=                 DELETE On Session                  API_Testing                                    /pet/22      headers=${header}
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

*** Keywords ***


