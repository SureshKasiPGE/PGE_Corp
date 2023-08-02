*** Settings ***
Resource                ../resources/common.resource
Resource                ../resources/AEM_PGE_Corp_Pages_keywords.robot
Test Teardown           Close All Excel Documents
Suite Setup             Setup Browser
Suite Teardown          End Suite

*** Test Cases ***

AEM_Pages_validation                   
    AEM_Url     3

Test
    ${Text_value}=         Get Excel Cell Value By Column Name     25        2             AEM
    ${Text_value1}=         Get Excel Cell Value By Column Name     13        2             AEM
    Get Variable Value     ${Text_value}  
    IF   '${Text_value1}' == '${empty}'
        Get Variable Value     ${Text_value1}
    END   