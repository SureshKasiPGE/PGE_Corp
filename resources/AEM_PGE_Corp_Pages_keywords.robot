*** Settings ***
Resource                  common.resource


*** Variables ***


*** Keywords ***

AEM_Url
    [Arguments]           ${RowLast}
    FOR                   ${i}                        IN RANGE    2           ${RowLast}
        ${Url}=           Get Excel Cell Value By Column Name     1           ${i}          AEM
        GoTo              ${Url}
        ${count}=         Get Excel Cell Value By Column Name     2           ${i}          AEM
        Get Variable Value                            ${count}
        FOR               ${j}                        IN RANGE    3                        ${count}     
            ${Header_type}=         Get Excel Cell Value By Column Name     ${j}           1          AEM
            IF   '${Header_type}' == 'Link_Text1'
                ${Link_value}=         Get Excel Cell Value By Column Name     ${j}        ${i}             AEM
                Sleep                  3
                ClickText              ${Link_value}
                CloseWindow                
            END
            ${Text_value}=         Get Excel Cell Value By Column Name     ${j}        ${i}             AEM
            Sleep                  3
            VerifyText             ${Text_value} 
        END
    END


