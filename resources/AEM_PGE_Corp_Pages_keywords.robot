*** Settings ***
Resource                common.resource

*** Variables ***


*** Keywords ***

AEM_Url
    [Arguments]     ${RowLast}
    FOR    ${i}    IN RANGE     2    ${RowLast}   
        ${Url}=    Get Excel Cell Value By Column Name    1   ${i}    AEM 
        GoTo    ${Url}
        ${count}=   Get Excel Cell Value By Column Name   2   ${i}    AEM 
        Get Variable Value                        ${count}
        Log                        ${count}
    END
                           

