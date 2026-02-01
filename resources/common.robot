*** Settings ***
Library    SeleniumLibrary
Resource    ../config/env.robot

*** Keywords ***
open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window



