*** Settings ***
Resource                ../resources/common.resource
Resource                ../resources/AEM_PGE_Corp_Pages_keywords.robot
Test Teardown           Close All Excel Documents
Suite Setup             Setup Browser
Suite Teardown          End Suite

*** Test Cases ***

AEM_Pages_validation                   
    AEM_Url     2