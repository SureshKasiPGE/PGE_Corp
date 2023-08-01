*** Settings ***
Resource                common.resource

*** Variables ***


*** Keywords ***

AEM_Url
    [Arguments]    ${RowInitial}    ${RowLast}
    FOR    ${i}    IN RANGE     ${RowLast}   Start=2
        ${Url}=    Get Excel Cell Value By Column Name    1   ${i}    AEM 
        GoTo    ${Url}
        ${count}=   Get Excel Cell Value By Column Name   2   ${i}    AEM  
    END
                           


