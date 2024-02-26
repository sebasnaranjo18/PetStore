*** Settings ***
Library                             JSONLibrary
Library                             Collections
Library                             SeleniumLibrary
Library                             RequestsLibrary

Resource                            ../Resources/resources.robot
Resource                            ../Robot_Resources/perftest.resource

*** Variables ***



*** Test Cases ***
Scenario:El Usuario Ejecuta Un Get Request Para Obtener El Inventario De La Tienda
        [Documentation]                  Get Request inventory

        ${header}=                       create dictionary                  Content-Type=application/xml
        create session                   API_Testing                        https://petstore3.swagger.io/api/v3
        ${Get_Response}=                 GET On Session                     API_Testing                                     /store/inventory
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario:El Usuario Ejecuta Un Post Request Para Crear Una Orden
        [Documentation]                  Post Request create order

        ${header}=                       create dictionary                   Content-Type=application/json
        ${body}=                         create dictionary                   id=10        petId=198772     quantity=11       shipDate=2024-02-26T01:51:24.691Z        status=approved        complete=true
        create session                   API_Testing_Post                    https://petstore3.swagger.io/api/v3
        ${response}=                     POST On Session                     API_Testing_Post             /store/order          json=${body}    headers=${header}
        log to console                   ${response.status_code}
        #validations
        ${code}                          convert to string                   ${response.status_code}
        should be equal                  ${code}                             200

        ${res_body}=                     convert to string                   ${response.content}
        should contain                   ${res_body}                         id
        should contain                   ${res_body}                         petId
        should contain                   ${res_body}                         quantity
        should contain                   ${res_body}                         shipDate
        should contain                   ${res_body}                         status
        should contain                   ${res_body}                         complete

Scenario:El Usuario Ejecuta Un Get Request Para Obtener Una Orden Segun Su ID
        [Documentation]                  Get Request inventory

        ${header}=                       create dictionary                  Content-Type=application/xml
        create session                   API_Testing                        https://petstore3.swagger.io/api/v3
        ${Get_Response}=                 GET On Session                     API_Testing                                    /store/order/10
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario:El Usuario Ejecuta Un Delete Request Para Eliminar Una Orden
        [Documentation]                  Delete Request order

        ${header}=                       create dictionary                  Content-Type=application/json
        create session                   API_Testing                        https://petstore3.swagger.io/api/v3
        ${Get_Response}=                 DELETE On Session                  API_Testing                                    /store/order/22
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

*** Keywords ***
