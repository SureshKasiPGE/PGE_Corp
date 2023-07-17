*** Settings ***
Library                         QForce
Library                         String
Library                         ExcelLibrary
Library                         SeleniumLibrary
Library                         QVision

*** Variables ***

${Environment}             Regression
${colNumTemp}        1
# IMPORTANT: Please read the readme.txt to understand needed variables and how to handle them!!
${BROWSER}                      Chrome
${home_url}                     ${login_url}/lightning/page/home
${queryEditorText}=             //*[@id\='queryEditorText']
${SelectFeature}=               //*[@role\='menuitem' and text()\='More']
${excel_worksheet}              ${CURDIR}/../PGE.xlsx
${excel_worksheet1}              ${CURDIR}/../PGE_SIT.xlsx

#vidhya pod-4 variables
#OT-400
${Acc_numfield}=                //input[@class\='vlocity-input slds-input']

#OT400 errormsg
${emptyerroe_msg}=              Error : Please enter account number
${wrongerrormsg1}=              Error: Your entry does not match the allowed pattern for *Account Number.
${correcterroe_msg}=            That account number has already been registered online.

#Ot-401/402/406

#random numbergenerator
${My_variable}=                 ${TEST_VARIABLE}
${NUMBER}=                      123456789
${SPECIAL_CHARACTER}=           !@$%^&*";.,?/"
${LETTERS}                      abcdefygh
*** Keywords ***
Setup Browser
    # Setting search order is not really needed here, but given as an example
    # if you need to use multiple libraries containing keywords with duplicate names
    Set Library Search Order    QForce                      QWeb
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow
    # Evaluate                  random.seed()               random                      # initialize random generator


End suite
    Close All Browsers

GetExcelData
    [Arguments]                 ${excel_workbook}     ${colName}
    Open Excel Document         ${excel_workbook}         doc_1
    ${col_names}=          Read Excel Row             1
    FOR                    ${col}    IN    ${col_names}
        IF    ${colName}==${col}  
            ${colNum}      Set Variable               ${colNumTemp}
            Log            ${colName}
            BREAK
        ELSE
            ${colNumTemp}                         Set Variable                ${colNumTemp}++
        END    
    END
    #Get Variable Value          ${product_names6}
    #Return From Keyword         ${product_names6}

    #Mrunal
home_url
    [Arguments]                 ${Value}                    ${link}
    GoTo                        https://publish-p55603-e${Value}.adobeaemcloud.com/${link}

    #vidhya
Pod3_login_url   
    Go To                       ${Pod3_Register_url}
Click_on_Element
    [Arguments]                 ${Choice_button}            ${anchor_value}

    ClickText                   ${Choice_button}            anchor=${anchor_value}

Register_function 
    [Arguments]                 ${PgE_customer}             ${Account_holder}
    Clicktext                   ${PgE_customer}             anchor=3
    ScrollTo                    OK, I’m Ready!              delay=2
    ClickText                   OK, I’m Ready!
    ClickText                   ${Account_holder}




accountlogin_verification

    [Arguments]                 ${Accfield}                 ${number}                   ${Error_msg}                ${CUrl}
    Account_error_validation    ${Accfield}                 ${number}                   ${Error_msg}
    VerifyText                  Try another or              delay=2
    ClickText                   Sign in
    VerifyUrl                   ${CUrl}
Account_Sign_in
    [Arguments]                 ${inputEmail}               ${inputpassword}            ${login}                    ${MFAbutton}
    TypeText                    Username                    ${inputEmail}               anchor=2
    TypeText                    Password                    ${inputpassword}
    ClickText                   ${login}
    ClickText                   ${MFAbutton}                anchor=4
    Sleep                       10





randomNumber_generatorfunction
    [Arguments]                 ${Length}                   ${Chara}                    ${Letters}
    Evaluate                    random.seed()               random
    ${random_N}=                Generate Random String      ${Length}                   ${Chara}${Letters}
    Return From Keyword         ${random_N}
    #Set Test Variable          ${My_variable}              ${random_N}
    #Log To Console             ${random_N}
    # ${variableOne}            Generate Random Number      3

checking_for_encapsulated_formate_mobNo
    [Arguments]                 ${Numberon_screen}
    ${AssocitedPHNO}=           Split String                ${Numberon_screen}          ,
    ${encaps_No}                Get Length                  ${AssocitedPHNO}

    FOR                         ${i}                        IN RANGE                    ${encaps_No}
        ${Phone_NO_onUI}        Set Variable                (***)***-${AssocitedPHNO}[${i}]
        VerifyText              ${Phone_NO_onUI}
    END



MFA_validation
    [Arguments]                 ${MFA_field}                ${code-MFA}                 ${confirms}                 ${TXT}
    Click Element               ${MFA_field}                #${EmailMFA_field}--variable
    ClearField
    TypeText                    ${MFA_field}                ${code-MFA}
    ClickText                   ${confirms}
    VerifyText                  ${TXT}

Encapsulated_number_verification
    [Arguments]                 ${Encaps_nu_onUI}
    ${AssocitedPHNO}=           Split String                ${Encaps_nu_onUI}           ,
    ${encaps_No}                Get Length                  ${AssocitedPHNO}

    FOR                         ${i}                        IN RANGE                    ${encaps_No}
        ${Phone_NO_onUI}        Set Variable                (***)***-${AssocitedPHNO}[${i}]
        VerifyText              ${Phone_NO_onUI}
    END





    #Vishnu
Generate Random numbers within range
    [Arguments]                 ${maxRange}                 ${NoOfRanNumReq}
    ${numbers}=                 Evaluate                    random.sample(range(1, ${maxRange}), ${NoOfRanNumReq})                   random
    Return From Keyword         ${numbers}

Enter the value

    [Arguments]                 ${field_Text}               ${field_Value}
    ClickText                   ${field_Text}
    ClearField
    TypeText                    ${field_Text}               ${field_Value}
    Sleep                       5

    #Meenusha
Login
    [Documentation]             Login to Salesforce instance
    GoTo                        ${login_url}
    TypeText                    Username                    ${username}                 delay=1
    TypeText                    Password                    ${password}
    ClickText                   Log In
    DefaultTimeout              200
    ${MFA_needed}=              Run Keyword And Return Status                           Should Not Be Equal         ${None}          ${secret}
    Run Keyword If              ${MFA_needed}               Fill MFA

Fill MFA
    ${mfa_code}=                GetOTP                      ${username}                 ${secret}                   ${login_url}
    TypeSecret                  Verification Code           ${mfa_code}
    ClickText                   Verify

Navigate to Feature
    [Arguments]                 ${Feature}
    ClickText                   ${SelectFeature}
    ClickText                   ${Feature}                  delay=5

Navigate to community portal
    [Arguments]                 ${text}
    #UseTable                   xpath\=//*[@id\='phHeader']
    #UseTable                   xpath\=//*[@id\='aura-pos-lib-1']
    ClickText                   Search...                   OmniStudio                  delay=30
    TypeText                    Search...                   ${text}\n
    #TypeText                   xpath\=//*[@id\='aura-pos-lib-1']                       ${text}\n
    ${present}=                 Run Keyword And Return Status                           Element Should Be Visible                    No Thanks
    Run Keyword If              ${present}                  ClickItem                   No Thanks
    ${text1}=                   Convert To Upper Case       ${text}
    ClickText                   ${text1}
    #ClickText                  //*[@id\='workWithPortalButton']                        delay=2
    ClickText                   Show more actions           delay=2
    ClickText                   Log in to Experience as User                            delay=2

LinkVerification
    [Arguments]                 ${xpath}                    ${attribute}                ${attribute_Value}          ${LinkText}
    VerifyAttribute             ${xpath}                    ${attribute}                ${attribute_Value}
    VerifyText                  ${LinkText}

ButtonVerification
    [Arguments]                 ${xpath}                    ${attribute}                ${attribute_Value}          ${ButtonText}
    VerifyAttribute             ${xpath}                    ${attribute}                ${attribute_Value}
    VerifyText                  ${ButtonText}

ExecuteQuery
    [Arguments]                 ${query}
    UseTable                    ${queryEditorText}
    ClickText                   ${queryEditorText}
    TypeText                    Enter SOQL or SOSL query: SELECT columns FROM type WHERE predicates | FIND what IN type FIELDS RETURNING type(columns)[...]         ${query}    delay=10
    ClickText                   Execute                     delay=3

GetSandboxObjects
    [Arguments]                 ${table_name}               ${col_counts}
    Use Table                   ${table_name}               anchor=2                    timeout=3
    ${Value_1}=                 GetValueIFElementVisible    r2c1                        ${col_counts}
    ${col_counts}               Evaluate                    ${col_counts}-1
    ${Value_2}=                 GetValueIFElementVisible    r2c2                        ${col_counts}
    ${col_counts}               Evaluate                    ${col_counts}-1
    ${Value_3}=                 GetValueIFElementVisible    r2c3                        ${col_counts}
    ${col_counts}               Evaluate                    ${col_counts}-1
    ${Value_4}=                 GetValueIFElementVisible    r2c4                        ${col_counts}
    ${col_counts}               Evaluate                    ${col_counts}-1
    ${list} =                   Create List                 ${Value_1}                  ${Value_2}                  ${Value_3}       ${Value_4}
    Return From Keyword         ${list}

GetValueIFElementVisible
    [Arguments]                 ${Row_Column}               ${col_counts}
    IF                          ${col_counts}==0
        Log To Console          No columns remaining to check
        ${Value}                setvariable                 null
    ELSE
        TRY
            ${Value}            GetCellText                 ${Row_Column}
        EXCEPT
            ${Value}            setvariable                 null
        END
    END
    #${present}=                Run Keyword And Return Status                           Element Should Be Visible                    ${Row_Column}
    #IF                         ${present}
    #                           ${Value}                    GetCellText                 ${Row_Column}
    #ELSE
    #                           ${Value}                    setvariable                 null
    #END
    Return From Keyword         ${Value}

CompareSandboxObjectValue
    [Arguments]                 ${Content}                  ${Sandbox_Object}           ${UI_Object}
    Log                         ${Content}
    LogScreenshot
    Should Be Equal As Strings                              ${Sandbox_Object}           ${UI_Object}


GoToSalesforceAPI
    [Arguments]                 ${salesforceAPI_UserIDObject}                           ${user_id}                  ${url}
    GoTo                        ${url}
    ${preview_present}=         Run Keyword And Return Status                           IsElement                   PREVIEW
    IF                          ${preview_present}
        ClickText               PREVIEW
    ELSE                        #verify else part as the code is wrong
        TypeText                Find in page                test\n
        ClickText               TEST/IP_PAYPLAN             delay=7
        ClickText               TEST/IP_PAYPLAN (Version 1)
        ClickText               PREVIEW
    END
    TypeText                    ${salesforceAPI_UserIDObject}                           ${user_id}                  delay=10
    ClickText                   Execute


VerifyErrorMsgOfInvalidUsernameorPassword                        #OT140
    [Documentation]             Verifying the error message if user enter invalid username or password
    [Arguments]                 ${username}                 ${password}                 ${login}
    TypeText                    Username                    ${username}                 anchor=2
    TypeText                    Password                    ${password}
    ClickText                   ${login}

    ${Error_Msg}                GetText                     ${Errormsg_xpath}
    IF                          '${Error_Msg}'=='${InvalidUsernameAndinvalidPassword_errormsg}'
        Log                     Invalid username and password
        ClearField
    ELSE IF                     '${Error_Msg}'=='${InvalidPassword_errormsg}'
        Log                     Invalid password
        ClearField
        ELSE
        ClearField
        ClearField
        Log                     valid username and password are entered
    END

TextVerification                
    [Arguments]                 ${Verifying_For}            ${ParaName}                 ${Para1}                    ${Para2}         ${Para3}           ${Para4}    ${Para5}    ${Para6}    ${Para7}    ${Para8}
    Log                         ${Verifying_For}
    VerifyText                  ${ParaName}
    VerifyTexts                 ${Para1}
    VerifyText                  ${Para2}
    VerifyText                  ${Para3}
    VerifyText                  ${Para4}
    VerifyText                  ${Para5}
    VerifyText                  ${Para6}
    VerifyText                  ${Para7}
    VerifyText                  ${Para8}

RemoveDoubleQuote
    [Arguments]                 ${serviceID_test}
    ${Value}=                   Remove String               ${serviceID_test}           "
    Return From Keyword         ${Value}
