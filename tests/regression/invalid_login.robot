*** Settings ***
Library    SeleniumLibrary
Resource   ../config/users.robot
Resource   ../resources/common.robot
Resource   ../resources/login_keywords.robot

Suite Setup     Open Browser To Login Page

*** Test Cases ***
Login invalide test
    Login With Invalid Credentials
    
    