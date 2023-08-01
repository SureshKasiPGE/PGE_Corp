*** Settings ***
Resource                common.resource

*** Variables ***


*** Keywords ***

AEM_Url
    [Arguments]     ${RowLast}
    FOR    ${i}    IN RANGE     ${RowLast}   
        ${Url}=    Get Excel Cell Value By Column Name    1   ${i}    AEM 
        GoTo    ${Url}
        ${count}=   Get Excel Cell Value By Column Name   2   ${i}    AEM 
        Get Variable Value                        ${count}
    END
                           
forloop
    FOR         ${i}                        IN RANGE                           1   4     +1
        Get Variable Value                  ${i}
    END

