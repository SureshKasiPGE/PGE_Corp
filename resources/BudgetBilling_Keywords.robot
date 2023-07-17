*** Settings ***
Library                         QForce
Library                         String
Library                         QVision
Library                         BuiltIn
Library                         OperatingSystem
Library                         Collections
Library                         SeleniumLibrary
Library                         DateTime

Resource                        ../resources/utils.robot

*** Variables ***
#xpath
${link_forSignUP} =             //*[@data-omni-key\='learnMoreAboutYourBill_UnderlinedLargeBold']
${signUP}=                      //*[text()\='Sign Up']
${Cancel_BudBilling}=           //*[text()\='Confirm Cancellation']
${queryEditorText}=             //*[@id\='queryEditorText']
${salesforceAPI_UserIDObject}=                              //*[@ng-model\='param.value']
${CCSP_Service_Agreement_ID}=                               (//*[contains(text(),'CCSP_Service_Agreement_ID_')])[value]/following::span[2]
${NewBudget}=                   (//*[contains(text(),'NewBudget')]/following::span[2])[value]
${BudgetAmount_locator}=        (//*[contains(text(),'BudgetAmount')]/following::span[2])[value]
${TotalBudget}=                 //*[contains(text(),'lNewBudget')]/following::span[2]
${TotalBudgetAmmount_locator}=                              //*[contains(text(),'lBudget')]/following::span[2]
${SalesforcAcc_locators_list}=                              (//*[@class\='slds-card slds-p-around_large budgetCard'])
${SalesforcAcc_locators}=       (//*[@class\='slds-card slds-p-around_large budgetCard'])[value]/div/div[dynamic]
${SalesforceAccBudBillingAcc_locator}=                      (//*[@class\='slds-card slds-p-around_large budgetCard'])[value]/div[2]
${effectiveDate_locator}=       //*[contains(text(),'NewBudgetDate')]/following::span[2]
${paymentamount_close_locator}=                             //*[@title\='Close']
${effectiveDate_UI_locator}=    //*[text()\='Effective Date']/following::p[1]
${payoffamount_UI_locator}=     //*[@class\='PayOffAmountClass']/following::p[1]

${user_NESS}=                   lourdes pedro
${userID_NESS}=                 0057b000003TAfFAAW
${user_NEMS2}=                  HUGH LEVENSON
${userID_NEMS2}=                0057b000003TBakAAG
${user_NEMS}=                   JACK SHAW
${userID_NEMS}=                 0057b000003TEw5AAG
${BudgetBilling_API_URL}=       https://pgeservice--myacdev2.sandbox.lightning.force.com/one/one.app#eyJjb21wb25lbnREZWYiOiJvbmU6YWxvaGFQYWdlIiwiYXR0cmlidXRlcyI6eyJhZGRyZXNzIjoiaHR0cHM6Ly9wZ2VzZXJ2aWNlLS1teWFjZGV2Mi5zYW5kYm94LmxpZ2h0bmluZy5mb3JjZS5jb20vYXBleC92bG9jaXR5X2NtdF9faW50ZWdyYXRpb25wcm9jZWR1cmVkZXNpZ25lcj9pZD1hN1E3YjAwMDAwMEVzdFBFQVMifSwic3RhdGUiOnt9fQ%3D%3D

#Regression
${user_NESS_Reg}=               lourdes pedro
${userID_NESS_Reg}=             0057b000003TAfFAAW
${user_NEMS2_Reg}=              HUGH LEVENSON
${userID_NEMS2_Reg}=            0057b000003TBakAAG
${user_NEMS_Reg}=               JACK SHAW
${userID_NEMS_Reg}=             0057b000003TEw5AAG
${BudgetBilling_API_URL_Reg}=                               https://pgeservice--myacdev2.sandbox.lightning.force.com/one/one.app#eyJjb21wb25lbnREZWYiOiJvbmU6YWxvaGFQYWdlIiwiYXR0cmlidXRlcyI6eyJhZGRyZXNzIjoiaHR0cHM6Ly9wZ2VzZXJ2aWNlLS1teWFjZGV2Mi5zYW5kYm94LmxpZ2h0bmluZy5mb3JjZS5jb20vYXBleC92bG9jaXR5X2NtdF9faW50ZWdyYXRpb25wcm9jZWR1cmVkZXNpZ25lcj9pZD1hN1E3YjAwMDAwMEVzdFBFQVMifSwic3RhdGUiOnt9fQ%3D%3D

#SIT
${user_NESS_SIT}=               lourdes pedro
${userID_NESS_SIT}=             0057b000003TAfFAAW
${user_NEMS2_SIT}=              HUGH LEVENSON
${userID_NEMS2_SIT}=            0057b000003TBakAAG
${user_NEMS_SIT}=               JACK SHAW
${userID_NEMS_SIT}=             0057b000003TEw5AAG
${BudgetBilling_API_URL_SIT}=                               https://pgeservice--myacdev2.sandbox.lightning.force.com/one/one.app#eyJjb21wb25lbnREZWYiOiJvbmU6YWxvaGFQYWdlIiwiYXR0cmlidXRlcyI6eyJhZGRyZXNzIjoiaHR0cHM6Ly9wZ2VzZXJ2aWNlLS1teWFjZGV2Mi5zYW5kYm94LmxpZ2h0bmluZy5mb3JjZS5jb20vYXBleC92bG9jaXR5X2NtdF9faW50ZWdyYXRpb25wcm9jZWR1cmVkZXNpZ25lcj9pZD1hN1E3YjAwMDAwMEVzdFBFQVMifSwic3RhdGUiOnt9fQ%3D%3D

*** Keywords ***

Salesforce Acc Details    
    [Arguments]                 ${value}                    ${list}                     ${Appendtolist}             ${effectiveDatePresence}
    ${value}                    Convert To String           ${value}
    VerifyText                  Account Number
    VerifyText                  Service Details
    VerifyText                  Budget Billing payment amount

    IF                          '${effectiveDatePresence}'=='Yes'
        ${effectiveDate_UI}=    GetText                     ${effectiveDate_UI_locator}
        Set Global Variable     ${effectiveDate_UI}         ${effectiveDate_UI}

        ${paypoffammount_UI}=                               GetText                     ${payoffamount_UI_locator}
        Set Global Variable     ${paypoffammount_UI}        ${paypoffammount_UI}
    END

    VerifyText                  Service Address
    ${SalesforcAcc_locators}=                               Replace String              ${SalesforcAcc_locators}    value                       ${value}
    ${accno}=                   Replace String              ${SalesforcAcc_locators}    dynamic                     1
    ${acc_no}=                  GetText                     ${accno}
    ${service_address}=         Remove String               ${acc_no}                   Service Address
    #Set Global Variable        ${service_address}          ${service_address}
    VerifyText                  Service ID
    ${SalesforcAcc_locators}=                               Replace String              ${SalesforcAcc_locators}    value                       ${value}
    ${accno}=                   Replace String              ${SalesforcAcc_locators}    dynamic                     2
    ${acc_no}=                  GetText                     ${accno}
    ${service_id}=              Remove String               ${acc_no}                   Service ID
    #Set Global Variable        ${service_id}               ${service_id}
    VerifyText                  Service Type
    ${SalesforcAcc_locators}=                               Replace String              ${SalesforcAcc_locators}    value                       ${value}
    ${accno}=                   Replace String              ${SalesforcAcc_locators}    dynamic                     3
    ${acc_no}=                  GetText                     ${accno}
    ${service_type}=            Remove String               ${acc_no}                   Service Type
    #Set Global Variable        ${service_type}             ${service_type}
    VerifyText                  Budget Billing Amount
    ${SalesforceAccBudBillingAcc_locator}=                  Replace String              ${SalesforceAccBudBillingAcc_locator}                   value                       ${value}
    ${acc_no}=                  GetText                     ${SalesforceAccBudBillingAcc_locator}
    ${budget_billing_account}=                              Remove String               ${acc_no}                   Budget Billing Amount
    ${budget_billing_account}=                              Remove String               ${budget_billing_account}                               $
    #Set Global Variable        ${budget_billing_account}                               ${budget_billing_account}
    VerifyText                  Account Number
    ${account_no}=              GetInputValue               Account Number
    Set Global Variable         ${account_no}               ${account_no}
    ScrollText                  ${bb_tips_1}
    VerifyText                  Budget Billing payment amount
    ${bud_billing_payment_account}=                         GetInputValue               Budget Billing payment amount
    ${bud_billing_payment_account1}=                        Remove String               ${bud_billing_payment_account}                          $
    Set Global Variable         ${bud_billing_payment_account1}                         ${bud_billing_payment_account1}
    IF                          '${Appendtolist}'=='Yes'
        Append to List          ${list}                     ${service_address}          ${service_id}               ${service_type}             ${budget_billing_account}
    END
    #Return From Keyword        ${list}


QueryToGetCommodity_typeFromService_ID
    [Arguments]                 ${service_id}
    ${query}=                   Set Variable                Select CCSP_Service_Agreement_ID__c, CCSP_Commodity_Type__c,vlocity_cmt__PremisesId__c from Asset WHERE CCSP_Service_Agreement_ID__c \= '${service_id}'
    Return From Keyword         ${query}

QueryToGetAddressFromPremisis_ID
    [Arguments]                 ${premisis_ID}
    ${query}=                   Set Variable                select vlocity_cmt__StreetAddress__c, vlocity_cmt__City__c, vlocity_cmt__State__c, vlocity_cmt__PostalCode__c from vlocity_cmt__Premises__c WHERE Id \= '${premisis_ID}'
    Return From Keyword         ${query}

NavigateToAccountDashboard
    ClickText                   My Account
    Navigate to Feature         Budget Bill

getServiceIDCount
    Navigate to Feature         Budget Bill
    ${total_Element_count}=     GetElementCount             ${SalesforcAcc_locators_list}
    FOR                         ${i}                        IN RANGE                    ${total_Element_count}
        ${i}                    Evaluate                    ${i}+1
        Salesforce Acc Details                              ${i}                        ${empty}                    No                          No
    END
    Return From Keyword         ${total_Element_count}

SignUP_Feature
    #Navigate to Feature        Budget Bill
    VerifyText                  Sign Up for Budget Billing
    ${total_Element_count}=     GetElementCount             ${SalesforcAcc_locators_list}
    ${list} =                   Create list
    FOR                         ${i}                        IN RANGE                    ${total_Element_count}
        ${i}                    Evaluate                    ${i}+1
        Salesforce Acc Details                              ${i}                        ${list}                     Yes                         No
    END
    ScrollText                  Back
    TextVerification            Sign Up for Budget Billing                              Budget Billing Tips         ${bb_program_1}             ${bb_program_2}             ${bb_program_3}             ${bb_tips_1}    ${bb_tips_2}    ${bb_tips_3}            ${empty}    ${empty}
    #No actual link is available in web page, in future need to modify if actual link is available
    LinkVerification            ${link_forSignUP}           data-omni-key               learnMoreAboutYourBill_UnderlinedLargeBold              Learn more about Budget Billing
    VerifyElement               ${signUP}
    ClickText                   Back
    Return From Keyword         ${list}

SignUPSuccess_Feature
    Navigate to Feature         Budget Bill
    ScrollText                  Back
    ClickText                   Sign Up
    TextVerification            Sign_up_success_msg         ${empty}                    ${Sign_up_success_msg}      ${sign_up_msg}              ${empty}                    ${empty}                    ${empty}        ${empty}        ${empty}    ${empty}
    ${total_Element_count}=     GetElementCount             ${SalesforcAcc_locators_list}
    ${list} =                   Create list
    FOR                         ${i}                        IN RANGE                    ${total_Element_count}
        ${i}                    Evaluate                    ${i}+1
        Salesforce Acc Details                              ${i}                        ${list}                     Yes                         No
    END
    Log                         ${list}
    TextVerification            SignUPSuccess_Feature       Next steps                  ${bb_program_3}             ${bb_tips_1}                ${empty}                    ${empty}                    ${empty}        ${empty}        ${empty}    ${empty}
    Return From Keyword         ${list}

ManageBudget_Feature
    VerifyText                  Manage Budget Billing
    VerifyText                  Enrolled in Budget Billing
    TextVerification            Manage_Budget_Billing       Budget Billing Tips         ${bb_manage_bb_para}        ${bb_manage_bbtips1}        ${bb_manage_bbtips2}        ${bb_manage_bbtips3}        ${empty}        ${empty}        ${empty}    ${empty}
    ${total_Element_count}=     GetElementCount             ${SalesforcAcc_locators_list}
    ${list} =                   Create list
    FOR                         ${i}                        IN RANGE                    ${total_Element_count}
        ${i}                    Evaluate                    ${i}+1
        Salesforce Acc Details                              ${i}                        ${list}                     Yes                         Yes
    END
    Log                         ${list}
    ClickText                   Payoff Amount
    sleep                       3
    TextVerification            Payoff ammount Details      ${bb_paymentamount_question}                            ${bb_paymentamount_answer}                              ${empty}                    ${empty}        ${empty}        ${empty}    ${empty}    ${empty}    ${empty}
    Click Element               ${paymentamount_close_locator}
    sleep                       3
    ScrollText                  Back
    ClickText                   Back
    Return From Keyword         ${list}

Cancel_Feature
    #Cancel Budget Billing Feature - Not included in TC, added steps to execute without any chaos for next run
    #ClickText                  My Account
    Navigate to Feature         Budget Bill
    ClickText                   Cancel Budget Billing
    ${cancelMessage}            Set Variable                ${bb_cancel_msg2} ${paypoffammount_UI}${bb_cancel_msg3}
    TextVerification            Cancel BudgetBilling success                            ${bb_cancel_msg1}           ${cancelMessage}            ${empty}                    ${empty}                    ${empty}        ${empty}        ${empty}    ${empty}    ${empty}
    ClickText                   ${Cancel_BudBilling}

CancelSuccess_Feature
    TextVerification            Cancel_Success_Message      Next steps                  ${bb_cancelsuccess_msg1}    ${bb_cancelsuccess_msg2}    ${bb_cancelsuccess_msg3}    ${bb_cancelsuccess_msg4}    ${empty}        ${empty}        ${empty}    ${empty}
    VerifyField                 Comparing the presence of Account Number                ${account_no}
    VerifyField                 Comparing the presence of Account balance               ${paypoffammount_UI}

SalesforceAPIVerification
    [Arguments]                 ${userID}                   ${total_Element_count}      ${list}                     ${SignUp}
    GoToSalesforceAPI           ${salesforceAPI_UserIDObject}                           ${userID}                   ${BudgetBilling_API_URL}

    ${j}                        Evaluate                    0
    FOR                         ${i}                        IN RANGE                    ${total_Element_count}
        ${k}                    Evaluate                    ${i}+1
        ${j}                    Evaluate                    ${j}+1
        ${value}                Convert To String           ${k}
        ${CCSP_Service_Agreement_ID}=                       Replace String              ${CCSP_Service_Agreement_ID}                            value                       1
        ${serviceID_test}=      GetText                     ${CCSP_Service_Agreement_ID}
        ${serviceID_test}=      RemoveDoubleQuote           ${serviceID_test}
        CompareSandboxObjectValue                           Comparing Service ID        ${serviceID_test}           ${list}[${j}]

        IF                      ${i}>0
            Click Element       ${CCSP_Service_Agreement_ID}
            PressKey            ${EMPTY}                    {PGDN}                      delay=2
        END

        ${j}                    Evaluate                    ${j}+2
        ${NewBudget}=           Replace String              ${NewBudget}                value                       1
        ${BudgetAmount_locator}=                            Replace String              ${BudgetAmount_locator}     value                       1
        IF                      '${SignUp}'=='No'
            ${Budgetammount_test}=                          GetText                     ${NewBudget}
        ELSE
            ${Budgetammount_test}=                          GetText                     ${BudgetAmount_locator}
        END
        ${Budgetammount_test}=                              RemoveDoubleQuote           ${Budgetammount_test}
        CompareSandboxObjectValue                           Comparing Budget Billing ammount                        ${Budgetammount_test}       ${list}[${j}]

        ${j}                    Evaluate                    ${j}+1
        Click Element           ${NewBudget}
        PressKey                ${EMPTY}                    {PGDN}                      delay=2
    END

    ClickText                   ${NewBudget}
    PressKey                    ${EMPTY}                    {CTRL + END}                delay=2
    ScrollTo                    "Accounts": [

    IF                          '${SignUp}'=='No'
        ${Budgetammount_test_ver}=                          GetText                     ${TotalBudget}
    ELSE
        ${Budgetammount_test_ver}=                          GetText                     ${TotalBudgetAmmount_locator}
    END
    ${Budgetammount_test_ver}=                              RemoveDoubleQuote           ${Budgetammount_test_ver}
    ${append}=                  Set Variable                /month
    ${Budgetammount_test_ver}=                              Set Variable                ${Budgetammount_test_ver} ${append}
    IF                          '${SignUp}'=='No'
        CompareSandboxObjectValue                           Comparing Budget Billing Payment ammount                ${Budgetammount_test_ver}                               ${bud_billing_payment_account1}
    ELSE
        CompareSandboxObjectValue                           Comparing Payment ammount                               ${Budgetammount_test_ver}                               ${bud_billing_payment_account1}

        ${effectiveDate_API}=                               GetText                     ${effectiveDate_locator}
        ${effectiveDate_API}=                               RemoveDoubleQuote           ${effectiveDate_API}_
        CompareSandboxObjectValue                           Comparing effective Date    ${effectiveDate_API}        ${effectiveDate_UI}
    END

    #${Budgetammount_test_ver}=                             Set Variable                ${Budgetammount_test_ver} ${append}
    #Log                        ${Budgetammount_test_ver}
    #CompareSandboxObjectValue                              Comparing Total Budget ammount                          ${Budgetammount_test_ver}                               ${bud_billing_payment_account1}




SalesforceSandboxObjectsVerification
    [Arguments]                 ${total_Element_count}      ${list}
    GoTo                        ${Sandbox_QueryEditor}

    ${j}                        Evaluate                    0
    FOR                         ${i}                        IN RANGE                    ${total_Element_count}
        ${j}                    Evaluate                    ${j}+1                      #to get service id from list which is the second element of each item
        ${service_id}=          Set Variable                ${list}[${j}]
        ${query}=               QueryToGetCommodity_typeFromService_ID                  ${service_id}
        ExecuteQuery            ${query}

        ${j}                    Evaluate                    ${j}-1                      #to get service address from list which is the first element of each item
        ${service_address}=     Set Variable                ${list}[${j}]
        ${words} =              Split String                ${service_address} ,'\,'
        Get Variable Value      ${words}[1]

        Log                     ${service_id}
        ${Sandbox_ObjectValue}=                             GetSandboxObjects           ${service_id}               3
        ${j}                    Evaluate                    ${j}+2                      #to get service type from list which is the third element of each item
        ${service_type}=        Set Variable                ${list}[${j}]
        ${service_type_SO}=     Set Variable                ${Sandbox_ObjectValue}[1]
        IF                      "${service_type_SO}"=="E"
            ${service_type_SO_value}=                       Set Variable                General Electric Meter
        ELSE IF                 "${service_type_SO}"=="G"
            ${service_type_SO_value}=                       Set Variable                General Gas Meter
        END
        #${service_type_SO_value}=                          Set Variable If             "${service_type_SO}"=="E"                               General Electric Meter
        #${service_type_SO_value}=                          Set Variable If             "${service_type_SO}"=="G"                               General Gas Meter
        CompareSandboxObjectValue                           Comparing Service Type      ${service_type_SO_value}    ${service_type}
        ${j}                    Evaluate                    ${j}+2                      #to complete the list for each loop to start fresh

        ${premisis_ID}=         Set Variable                ${Sandbox_ObjectValue}[2]

        ${query}=               QueryToGetAddressFromPremisis_ID                        ${premisis_ID}
        ExecuteQuery            ${query}

        ${Sandbox_ObjectValue}=                             GetSandboxObjects           ${words}[0]                 4
        ${Sandbox_ObjectValues}=                            Get Substring               ${Sandbox_ObjectValue}[3]                               0                           5
        ${service_address_SO}=                              Set Variable                ${Sandbox_ObjectValue}[0] ${Sandbox_ObjectValue}[1] ${Sandbox_ObjectValue}[2] ${Sandbox_ObjectValues}
        ${service_address}=     Remove String               ${service_address}          ,
        CompareSandboxObjectValue                           Comparing Service address                               ${service_address_SO}       ${service_address}
    END
