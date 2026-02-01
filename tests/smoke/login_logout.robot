*** Settings ***
Library    SeleniumLibrary
Resource   ../../resources/common.robot
Resource   ../../config/users.robot
Resource   ../../resources/login_keywords.robot

Resource   ../resources/add_user_Keyw.robot


Suite Setup     Open Browser To Login Page

*** Test Cases ***
Login OrangeHRM
    Login With Valid Credentials
    Wait Until Page Contains    Dashboard    10s
    Add User Test
    Wait Until Page Contains    System Users    15s

    # Logout
    Logout From Application


  

    


