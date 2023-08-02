*** Settings ***
Resource                  common.resource

*** Variables ***


*** Keywords ***

AEM_Url
    [Arguments]           ${RowLast}
    ${test}=         Get Excel Cell Value By Column Name     11        2             AEM
    Get Variable Value                        ${test}
    Sleep                        60
    FOR                   ${i}                        IN RANGE    2           ${RowLast}
        ${Url}=           Get Excel Cell Value By Column Name     1           ${i}          AEM
        GoTo              ${Url}
        ${count}=         Get Excel Cell Value By Column Name     2           ${i}          AEM
        Get Variable Value                            ${count}
        FOR               ${j}                        IN RANGE    3                        ${count}     
            ${Header_type}=         Get Excel Cell Value By Column Name     ${j}           1          AEM
            
            IF   '${Header_type}' == 'Link_Text'                     
                ${Link_value}=         Get Excel Cell Value By Column Name     ${j}        ${i}             AEM
                IF   '${Link_value}' != '${EMPTY}'
                    Sleep                  3
                    ClickText              ${Link_value}
                    Sleep                  3
                    SwitchWindow           2
                    Sleep                  3
                    CloseWindow  
                END    
            ELSE IF   '${Header_type}' != 'Link_Text'
                ${Text_value}=         Get Excel Cell Value By Column Name     ${j}        ${i}             AEM
                #${Removed_Qouates_value}=                        RemoveDoubleQuote      ${Text_value}
                #${finalvalue}=                        RemoveSingleQuote                 ${Removed_Qouates_value}
                IF   '${Text_value}' != '${empty}'
                    Sleep                  3
                    #VerifyText             ${Text_value} 
                END                    
            END   
        END
    END


