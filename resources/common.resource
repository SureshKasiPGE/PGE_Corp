*** Settings ***
Library                         QWeb
Library                         ExcelLibrary
Library                         String
Library                         BuiltIn
Library                         ../libraries/GitOperations.py

*** Variables ***
${BROWSER}                      chrome
${webshop}                      https://qentinelqi.github.io/shop/
${excel_worksheet}              ${CURDIR}/../data/products_worksheet.xlsx
${git_branch}                   main

#AEM
${excel_worksheet_AEM}          ${CURDIR}/../data/AEM_Page_Validation.xlsx

*** Keywords ***
Setup Browser
    Open Browser                about:blank                 ${BROWSER}
    Evaluate                    random.seed()               random        # initialize random generator

End Suite
    Close All Browsers


Get Excel Cell Value By Column Name
    [Arguments]                 ${colNum}                   ${rowNum}     ${sheet}
    Open Excel Document         ${excel_worksheet_AEM}      doc_1
    ${testdata}=                Read Excel Cell             ${rowNum}     ${colNum}                   ${sheet}
    Get Variable Value          ${testdata}
    Close Current Excel Document
    Return From Keyword         ${testdata}
    
RemoveDoubleQuote
    [Arguments]                 ${serviceID_test}
    ${Value}=                   Remove String               ${serviceID_test}           "
    Return From Keyword         ${Value}    