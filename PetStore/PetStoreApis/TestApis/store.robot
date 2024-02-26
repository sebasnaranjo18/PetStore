*** Settings ***
Library                             JSONLibrary
Library                             Collections
Library                             SeleniumLibrary
Library                             RequestsLibrary

Resource                            ../Resources/resources.robot

*** Variables ***



*** Test Cases ***
Scenario:El Usuario Ejecuta Un Get Request Para Obtener El Inventario De La Tienda
        [Documentation]                  Get Request inventory

        ${header}=                       create dictionary                  Content-Type=application/xml
        create session                   API_Testing                        ${PETSTOREAPI}
        ${Get_Response}=                 GET On Session                     API_Testing                                     /store/inventory
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario:El Usuario Ejecuta Un Post Request Para Crear Una Orden
        [Documentation]                  Post Request create order

        ${header}=                       create dictionary                   Content-Type=application/json
        ${body}=                         create dictionary                   id=${IDSTORE}[idstore]        petId=${PETID}[petId]     quantity=${QUANTITY}[quantity]       shipDate=${SHIPDATE}[shipDate]        status=${STATUS}[status]        complete=${COMPLETE}[complete]
        create session                   API_Testing_Post                    ${PETSTOREAPI}
        ${response}=                     Post Request                        API_Testing_Post             /store/order          data=${body}    headers=${header}
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
        create session                   API_Testing                        ${PETSTOREAPI}
        ${Get_Response}=                 GET On Session                     API_Testing                                    /store/order/${IDSTORE}[idstore]
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario:El Usuario Ejecuta Un Delete Request Para Eliminar Una Orden
        [Documentation]                  Delete Request order

        ${header}=                       create dictionary                  Content-Type=application/json
        create session                   API_Testing                        ${PETSTOREAPI}
        ${Get_Response}=                 delete on session                   API_Testing                                    /store/order/${IDSTORE}[idstore]
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

*** Keywords ***
