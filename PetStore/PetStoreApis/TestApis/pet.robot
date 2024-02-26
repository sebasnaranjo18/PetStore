*** Settings ***
Library                             JSONLibrary
Library                             Collections
Library                             SeleniumLibrary
Library                             RequestsLibrary
Library                             xml

Resource                            ../Resources/resources.robot
Resource                            ../images/Mia.jpg

*** Variables ***



*** Test Cases ***
Scenario:El Usuario Ejecuta Un Post Request Para Agregar Una Mascota
        [Documentation]                  Post Request add pet

        create session                   API_Testing_Post                    ${PETSTOREAPI}
        ${header}=                       create dictionary                   Content-Type=application/xml                accept=application/xml
        ${xml}=                          set variable                        <pet><id>10</id><name>doggie</name><category><id>1</id><name>Dogs</name></category><photoUrls><photoUrl>string</photoUrl></photoUrls><tags><tag><id>0</id><name>string</name></tag></tags><status>available</status></pet>
        ${response}=                     POST On Session                     API_Testing_Post             /pet          data=${xml}    headers=${header}
        log to console                   ${response.status_code}
        #validations
        ${code}                          convert to string                   ${response.status_code}
        should be equal                  ${code}                             200

Scenario:El Usuario Ejecuta Un Put Request Para Actualizar Una Mascota
        [Documentation]                  Put Request update pet

        create session                  API_Testing_Post                     ${PETSTOREAPI}
        ${header}=                      create dictionary                    Content-Type=application/xml                accept=application/xml
        ${xml}=                         set variable                         <pet><id>10</id><name>MiaMarcela</name><category><id>1</id><name>criollo</name></category><photoUrls><photoUrl>string</photoUrl></photoUrls><tags><tag><id>0</id><name>string</name></tag></tags><status>available</status></pet>
        ${response}=                    PUT On Session                       API_Testing_Post             /pet          data=${xml}    headers=${header}
        log to console                  ${response.status_code}
        #validations
        ${code}                          convert to string                   ${response.status_code}
        should be equal                  ${code}                             200

Scenario:El Usuario Ejecuta Un Get Request Para Obtener Informacion De Una Mascota Segun Su Tag
        [Documentation]                  Get Request searching pet by tag

        ${header}=                       create dictionary                  Content-Type=application/xml
        create session                   API_Testing                        ${PETSTOREAPI}
        ${Get_Response}=                 GET On Session                     API_Testing                                     url=/pet/findByTags?tags=${TAGS}[tags]       headers=${header}
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario:El Usuario Ejecuta Un Get Request Para Obtener Informacion De Una Mascota Segun Su Status
        [Documentation]                  Get Request searching pet by status

        ${header}=                       create dictionary                  Content-Type=application/xml
        create session                   API_Testing                        ${PETSTOREAPI}
        ${Get_Response}=                 GET On Session                     API_Testing                                     url=/pet/findByStatus?status=${PETSTATUS}[petstatus]       headers=${header}
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario:El Usuario Ejecuta Un Get Request Para Obtener Informacion De Una Mascota Segun Su ID
        [Documentation]                  Get Request searching pet by id

        ${header}=                       create dictionary                  Content-Type=application/xml
        create session                   API_Testing                        ${PETSTOREAPI}
        ${Get_Response}=                 GET On Session                     API_Testing                                     url=/pet/${IDPET}[idpet]       headers=${header}
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

Scenario:El Usuario Ejecuta Un Delete Request Para Eliminar Una Mascota
        [Documentation]                  Delete Request pet

        ${header}=                       create dictionary                  Content-Type=application/json
        create session                   API_Testing                        ${PETSTOREAPI}
        ${Get_Response}=                 delete on session                   API_Testing                                    /pet/${IDPET}[idpet]       headers=${header}
        log to console                   ${Get_Response.status_code}
        ${statusCode}=                   convert to string                  ${Get_Response.status_code}
        should be equal                  ${statusCode}                      200

*** Keywords ***


