*** Settings ***
Resource                        ../resources/utils.robot
Resource                        ../resources/BudgetBilling_Keywords.robot
Library                         QForce

Suite Setup                     Setup Browser
Suite Teardown                  End suite
#Test Setup                      Setup Browser
#Test Teardown                   End suite

*** Test Cases ***

BudgetBilling_nonenrolled1
    [Documentation]                                Executing the accound for non enrolled customer
    [tags]                                         BudgetBilling        Regression        Sanity
    ${Environment}                              Set Variable                   Regression
    GoTo                        https://pgeservicetest.pge.com/myaccount  
    ${product_names6}                        GetExcelValue                        2            2             Data     ${excel_worksheet}
    Get Variable Value                       ${product_names6}



BudgetBilling_nonenrolled
    [Documentation]                                Executing the accound for non enrolled customer
    [tags]                                         BudgetBilling_Regression     BudgetBilling_SIT       Regression     SIT   Sanity
    ${product_names6}                        GetExcelValue                        2                        2                        Data
    Get Variable Value                       ${product_names6}
    Login
    Navigate to community portal                   ${user_NEMS}  
    GoTo                        https://pgeservice--myacdev2.sandbox.my.site.com/myaccount
    ${total_Element_count}=                        getServiceIDCount
    ${list}=                                       SignUP_Feature
    Get Variable Value                             ${list}
    SalesforceSandboxObjectsVerification           ${total_Element_count}    ${list}
    SalesforceAPIVerification                      ${userID_NEMS}            ${total_Element_count}    ${list}    No
    GoTo                                           ${login_url}
    Navigate to community portal                   ${user_NEMS}
    GoTo                        https://pgeservice--myacdev2.sandbox.my.site.com/myaccount
    ${list1}=                                      SignUPSuccess_Feature
    Lists Should Be Equal                          ${list}                   ${list1}
    NavigateToAccountDashboard
