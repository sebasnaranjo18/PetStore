*** Settings ***
Library                             OperatingSystem
Library                             SeleniumLibrary

*** Variables ***
#Endpoints Env
#Dev Env
${PETSTOREAPI}                   https://petstore3.swagger.io/api/v3
&{USERNAME}                      username=theUser
&{PASSWORD}                      password=1234

&{NAMEUSER2}                     nameuser2=alejo

#user payloads
&{ID}                           id=10011
&{NAMEUSER}                     nameuser=sebas
&{FIRSTNAME}                    firstName=sebastian
&{LASTNAME}                     lastName=naranjo
&{EMAIL}                        email=sebas@email.com
&{PASS}                         pass=12345
&{PHONE}                        phone=12345
&{USERSTATUS}                   userStatus=1


#update
&{IDUP}                           idup=11001
&{NAMEUSERUP}                     nameuserup=sebastian
&{FIRSTNAMEUP}                    firstNameup=sebas
&{LASTNAMEUP}                     lastNameup=ortiz
&{EMAILUP}                        emailup=ortiz@email.com
&{PASSUP}                         passup=12345
&{PHONEUP}                        phoneup=12345
&{USERSTATUSUP}                   userStatusup=1

#store payloads
&{IDSTORE}                        idstore=10
&{PETID}                          petId=198772
&{QUANTITY}                       quantity=11
&{SHIPDATE}                       shipDate=2024-02-26T01:51:24.691Z
&{STATUS}                         status=approved
&{COMPLETE}                       complete=true

#pet
&{IDPET}                           idpet=22
&{TAGS}                            tags=string
&{PETSTATUS}                       petstatus=available
&{NAMEPET}                         namepet=MiaMArcela



