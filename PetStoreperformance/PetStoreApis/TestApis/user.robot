*** Settings ***
Library                             JSONLibrary
Library                             Collections
Library                             SeleniumLibrary
Library                             RequestsLibrary

Resource                            ../Resources/resources.robot
Resource                            ../Robot_Resources/perftest.resource

*** Variables ***


*** Test Cases ***
Scenario: The User Executes a Get Request to Login to the Application
        [Documentation]                  Get Request login user

        ${header}=                       create dictionary                  Content-Type=application/xml
        create session                   API_Testing                        https://petstore3.swagger.io/api/v3
        ${Get_Response}=                 GET On Session                     API_Testing                                     url=/user/login?username=theUser&password=1234
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario:User Executes a Post Request to Create a User
        [Documentation]                  Post Request create user

        #validate the login status code and validation of response test apiendpoint
        ${header}=                       create dictionary                  Content-Type=application/json
        ${body}=                         create dictionary                  id=10011        username=sebas    firstName=sebastian       lastName=naranjo       email=sebas@email.com        password=12345       phone=123456789       userStatus=1
        create session                   API_Testing_Post                   https://petstore3.swagger.io/api/v3
        ${response}=                     Post Request                       API_Testing_Post             /user          data=${body}    headers=${header}
        log to console                   ${response.status_code}
        #validations
        ${code}                          convert to string                  ${response.status_code}
        should be equal                  ${code}                            200
        ${res_body}=                     convert to string                  ${response.content}
        should contain                   ${res_body}                        id
        should contain                   ${res_body}                        username
        should contain                   ${res_body}                        firstName
        should contain                   ${res_body}                        lastName
        should contain                   ${res_body}                        email
        should contain                   ${res_body}                        password
        should contain                   ${res_body}                        phone
        should contain                   ${res_body}                        userStatus

Scenario:User Executes a Post Request to Create a List of Users
        [Documentation]                  Post Request create list of user

        #validate the login status code and validation of response test apiendpoint
        ${header}=                       create dictionary                  Content-Type=application/xml
        ${body}=                         create dictionary                  id=10011        username=sebas    firstName=sebastian       lastName=naranjo       email=sebas@email.com        password=12345       phone=123456789       userStatus=1
        ${list}                          create list                        ${body}
        create session                   API_Testing_Post                   https://petstore3.swagger.io/api/v3
        ${response}=                     Post Request                       API_Testing_Post             /user/createWithList          data=${list}    headers=${header}
        log to console                   ${response.status_code}
        #validations
        ${code}                          convert to string                  ${response.status_code}
        should be equal                  ${code}                            200
        ${res_body}=                     convert to string                  ${response.content}
        should contain                   ${res_body}                        id
        should contain                   ${res_body}                        username
        should contain                   ${res_body}                        firstName
        should contain                   ${res_body}                        lastName
        should contain                   ${res_body}                        email
        should contain                   ${res_body}                        password
        should contain                   ${res_body}                        phone
        should contain                   ${res_body}                        userStatus

Scenario:The User Executes A Get Request To Query A User With Their Username
        [Documentation]                  get Request user username

        ${header}=                       create dictionary                  Content-Type=application/json
        create session                   API_Testing                        https://petstore3.swagger.io/api/v3
        ${Get_Response}=                 GET On Session                     API_Testing                                     /user/sebas
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario:User Executes a Put Request to Update a User
        [Documentation]                  Put Request update user

        ${header}=                      create dictionary                   Content-Type=application/json
        ${body}=                        create dictionary                   id=11001        username=sebastian    firstName=sebas       lastName=naranjos       email=sebasno@email.com        password=123456       phone=12345678910       userStatus=1
        create session                  API_Testing_Post                    https://petstore3.swagger.io/api/v3
        ${response}=                     put request                        API_Testing_Post             /user/alejo         data=${body}    headers=${header}
        log to console                   ${response.status_code}
        #validations
        ${code}                          convert to string                  ${response.status_code}
        should be equal                  ${code}                            200
        ${res_body}=                     convert to string                  ${response.content}
        should contain                   ${res_body}                        id
        should contain                   ${res_body}                        username
        should contain                   ${res_body}                        firstName
        should contain                   ${res_body}                        lastName
        should contain                   ${res_body}                        email
        should contain                   ${res_body}                        password
        should contain                   ${res_body}                        phone
        should contain                   ${res_body}                        userStatus

Scenario:User Executes a Delete Request to Delete a User
        [Documentation]                  Delete Request user

        ${header}=                       create dictionary                  Content-Type=application/json
        create session                   API_Testing                        https://petstore3.swagger.io/api/v3
        ${Get_Response}=                 delete on session                  API_Testing                                     /user/sebas
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

*** Keywords ***
