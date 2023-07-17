*** Settings ***
Library                 QWeb
Library                 ExcelLibrary
Library                 String
Library                 ../libraries/GitOperations.py

*** Variables ***
${BROWSER}              chrome
${webshop}              https://qentinelqi.github.io/shop/
${excel_worksheet}      ${CURDIR}/../data/PGE.xlsx
${git_branch}           main

*** Keywords ***
Setup Browser
    Open Browser        about:blank     ${BROWSER}
    Evaluate            random.seed()    random    # initialize random generator

End Suite
    Close All Browsers

GetExcelValue
    [Arguments]                 ${rowNum}                    ${colNum}        ${sheet_names}
    Open Excel Document         ${excel_worksheet}          products
    ${product_names6}=          Read Excel Cell             ${rowNum}         ${colNum}        ${sheet_names}
    Get Variable Value          ${product_names6}
    Return From Keyword         ${product_names6}
