*** Settings ***
Library                 QWeb
Library                 ExcelLibrary
Library                 String
Library                 ../libraries/GitOperations.py
Resource                common.resource

*** Variables ***
${BROWSER}              chrome
${webshop}              https://qentinelqi.github.io/shop/
${excel_worksheet}      ${CURDIR}/../data/products_worksheet.xlsx
${git_branch}           main

*** Keywords ***

AEM_Url
    [Arguments]    ${Column}    ${Row}
    ${Url}=    Get Excel Cell Value By Column Name    ${Column}   ${Row}    AEM 
    Log        ${Url}
    GoTo    ${Url}    

