*** Settings ***
Resource                ../Resource/common.resource
Test Teardown           Close All Excel Documents
Suite Setup             Setup Browser
Suite Teardown          End Suite

*** Test Cases ***
Verify Products
    [Documentation]     Read product names from excel sheet and verify that those can be found from a webshop page
    [Tags]              excel    products    verify
    GoTo                ${webshop}
    VerifyText          Find your spirit animal

    ${product_names6}                        GetExcelValue                        2                        2                        Data
    Get Variable Value                       ${product_names6}



    # # Open existing workbook
    # Open Excel Document    ${excel_worksheet}    products

    # # Start reading values from the second row, max number needs to be provided with offset
    # ${product_names}=   Read Excel Column    col_num=1    max_num=3    row_offset=1    sheet_name=Fur
    # ${product_names1}=   Read Excel Column    col_num=2    max_num=3    row_offset=1    sheet_name=Fur
    #  ${product_names2}=   Read Excel Column    col_num=1    max_num=3    row_offset=1    sheet_name=Data
    # ${product_names3}=   Read Excel Column    col_num=2    max_num=3    row_offset=1    sheet_name=Data
    
    
    # ${product_names6}=   Read Excel Cell    col_num=2      row_num=2           sheet_name=Data
    # Get Variable Value                   ${product_names6}

    # # Check that we can find all the products from the web page
    # FOR    ${item}    IN    @{product_names}
    #     Get Variable Value                   ${item}
    #     #VerifyText           ${item}
    # END

    # FOR    ${item}    IN    @{product_names1}
    #     Get Variable Value                   ${item}
    #     #VerifyText           ${item}
    # END

    # FOR    ${item}    IN    @{product_names2}
    #     Get Variable Value                   ${item}
    #     #VerifyText           ${item}
    # END

    # FOR    ${item}    IN    @{product_names3}
    #     Get Variable Value                   ${item}
    #     #VerifyText           ${item}
    # END
