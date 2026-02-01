*** Settings ***
Library    SeleniumLibrary
Resource    ../config/users.robot
Resource   ../resources/common.robot
Resource   ../resources/login_keywords.robot

*** Keywords ***
Add User Test
        Wait Until Element Is Visible    //*[@id="app"]/div[1]/div[1]/aside/nav/div[2]/ul/li[1]/a    10s
    Click Element    //*[@id="app"]/div[1]/div[1]/aside/nav/div[2]/ul/li[1]/a

    Wait Until Element Is Visible    //*[@id="app"]/div[1]/div[2]/div[2]/div/div[2]/div[1]/button    10s
    Click Button    //*[@id="app"]/div[1]/div[2]/div[2]/div/div[2]/div[1]/button

    Wait Until Element Is Visible    //form//i[contains(@class,'oxd-icon')]    10s
    Click Element    //form//i[contains(@class,'oxd-icon')]

    Wait Until Element Is Visible    //form//div[@role='listbox']//span[text()='Admin']    10s
    Click Element    //form//div[@role='listbox']//span[text()='Admin']

    Wait Until Element Is Visible    //input[@placeholder='Type for hints...']    10s
    #Input Text    //input[@placeholder='Type for hints...']    ${Employee Name}
    Sleep    1s
     Input Text     //input[@placeholder='Type for hints...']    ${Employee Name}    Ran
     Sleep    2s
     Wait Until Element Is Visible    ${FIRST_EMPLOYEE}    10s
     Sleep    1s
     Click Element    ${FIRST_EMPLOYEE}


    Wait Until Element Is Visible      //*[@id="app"]/div[1]/div[2]/div[2]/div/div/form/div[1]/div/div[3]/div/div[2]/div/div/div[2]/i    10s
    Click Element    //*[@id="app"]/div[1]/div[2]/div[2]/div/div/form/div[1]/div/div[3]/div/div[2]/div/div/div[2]/i

    Wait Until Element Is Visible    //div[@role='listbox']//span[text()='Enabled']    10s
    Click Element    //div[@role='listbox']//span[text()='Enabled']



    Wait Until Element Is Visible    //*[@id="app"]/div[1]/div[2]/div[2]/div/div/form/div[1]/div/div[4]/div/div[2]/input  10s
    Input Text    //*[@id="app"]/div[1]/div[2]/div[2]/div/div/form/div[1]/div/div[4]/div/div[2]/input   ${Mon-Nom}      
    
    Wait Until Element Is Visible       //input[@type='password']    10s
    Input Text    //input[@type='password']    ${Pss} 

    Wait Until Element Is Visible       //*[@id="app"]/div[1]/div[2]/div[2]/div/div/form/div[2]/div/div[2]/div/div[2]/input    10s
    Input Text    //*[@id="app"]/div[1]/div[2]/div[2]/div/div/form/div[2]/div/div[2]/div/div[2]/input    ${Pss} 

    Wait Until Element Is Visible    //*[@id="app"]/div[1]/div[2]/div[2]/div/div/form/div[3]/button[2]    10s
    Click Button    //*[@id="app"]/div[1]/div[2]/div[2]/div/div/form/div[3]/button[2]
    Sleep    6s