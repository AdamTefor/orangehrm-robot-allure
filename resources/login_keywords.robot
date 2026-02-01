*** Settings ***
Library    SeleniumLibrary
Resource    ../config/users.robot
Resource    ../config/env.robot

*** Keywords ***
Login With Valid Credentials
    Wait Until Element Is Visible     name:username   10s
    Input Text    name:username    ${USERNAME}

    Wait Until Element Is Visible   name:password   10s
    Input Text    name:password    ${PASSWORD}

    Click Button    xpath://button[@type='submit']
    Wait Until Page Contains    Dashboard    10s

Login With Invalid Credentials
    Wait Until Element Is Visible     name:username   10s
    Input Text    name:username    ${USERNAME}

    Wait Until Element Is Visible   name:password   10s
    Input Text    name:password    ${INVALID_PASSWORD}

    Click Button    xpath://button[@type='submit']
    Wait Until Page Contains    Invalid credentials    10s
    Capture Page Screenshot

Logout From Application
    Wait Until Element Is Visible    ${icon-DashboardLogout}     15s
    Click Element    ${icon-DashboardLogout}  

    Wait Until Element Is Visible    ${icon-Logout}    20s
    Capture Page Screenshot
    Click Element    ${icon-Logout} 

    Wait Until Element Is Visible    //*[@id="app"]/div[1]/div/div[1]/div/div[2]/h5     10s
    Capture Page Screenshot

