*** Settings ***
Resource                common.resource

*** Variables ***


*** Keywords ***

AEM_Url
    [Arguments]    ${Column}    ${Row}
    ${Url}=    Get Excel Cell Value By Column Name    ${Column}   ${Row}    AEM 
    GoTo    ${Url}   
     

