*** Settings ***
Test Setup        Open Browser    ${URL}    ${BROWSER}
Test Teardown     Close Browser
Library           SeleniumLibrary

*** Variables ***
${URL}            https://demowebshop.tricentis.com/register
${BROWSER}        Chrome
${PRENOM}         Jean
${NOM}            Dupont
# Important : Change un peu l'email si tu relances le test (ex: jean02, jean03...)
# car le site refuse deux fois la même adresse.
${EMAIL}          jean.dupont.test010@test.com
${PASSWORD}       Secret123!
${LOC_GENRE_M}    id:gender-male
${LOC_GENRE_F}    id:gender-female
${LOC_PRENOM}     id:FirstName
${LOC_NOM}        id:LastName
${LOC_EMAIL}      id:Email
${LOC_PASS}       id:Password
${LOC_CONFIRM}    id:ConfirmPassword
${LOC_BOUTON}     id:register-button
${LOC_SUCCESS}    class:result
${LOC_ERROR}      class:field-validation-error

*** Test Cases ***
Test 01 : Vérifier les Champs Obligatoires
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Click Element    ${LOC_BOUTON}
    Page Should Contain    First name is required.
    Page Should Contain    Last name is required.
    Page Should Contain    Email is required.
    Page Should Contain    Password is required.
    Log    Succès : La complétude est respectée (champs vides bloqués).

Test 02 : Vérifier le Format Email
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    ${PRENOM}
    Input Text    ${LOC_NOM}    ${NOM}
    Input Text    ${LOC_EMAIL}    jean.dupont-pas@emai
    Input Text    ${LOC_PASS}    ${PASSWORD}
    Input Text    ${LOC_CONFIRM}    ${PASSWORD}
    Click Element    ${LOC_BOUTON}
    Page Should Contain    Wrong email
    Log    Succès : L'exactitude est respectée (mauvais format rejeté).

Test 03 : Vérifier la Correspondance des Mots de Passe
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    ${PRENOM}
    Input Text    ${LOC_NOM}    ${NOM}
    Input Text    ${LOC_EMAIL}    ${EMAIL}
    Input Text    ${LOC_PASS}    ${PASSWORD}
    Input Text    ${LOC_CONFIRM}    123456
    Click Element    ${LOC_BOUTON}
    Page Should Contain    The password and confirmation password do not match.
    Log    Succès : La cohérence est respectée (différence détectée).

Test 04 : Cas Nominal (Tout est OK)
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    ${PRENOM}
    Input Text    ${LOC_NOM}    ${NOM}
    Input Text    ${LOC_EMAIL}    ${EMAIL}
    Input Text    ${LOC_PASS}    ${PASSWORD}
    Input Text    ${LOC_CONFIRM}    ${PASSWORD}
    Click Element    ${LOC_BOUTON}
    Wait Until Page Contains Element    ${LOC_SUCCESS}    timeout=5s
    Log    Succès : Formulaire validé !

Test 05 : Test des Limites (Mot de passe trop court)
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    ${PRENOM}
    Input Text    ${LOC_NOM}    ${NOM}
    Input Text    ${LOC_EMAIL}    test.debug.01@test.com
    Input Text    ${LOC_PASS}    123
    Input Text    ${LOC_CONFIRM}    123
    Click Element    ${LOC_BOUTON}
    Page Should Contain    The password should have at least 6 characters.
    Log    Succès.

Test 06 : Sécurité - Injection XSS (Scripting)
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    <script>alert('Hacked')</script>
    Input Text    ${LOC_NOM}    ${NOM}
    Input Text    ${LOC_EMAIL}    test.xss.secure@test.com
    Input Text    ${LOC_PASS}    ${PASSWORD}
    Input Text    ${LOC_CONFIRM}    ${PASSWORD}
    Click Element    ${LOC_BOUTON}
    Run Keyword And Expect Error    *Alert not found*    Handle Alert    timeout=1s
    Page Should Contain    internal error occurred
    Log    Succès : Le serveur a détecté le script dangereux et a bloqué la page (Erreur 500).

Test 07 : Sécurité - Injection SQL
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    ${PRENOM}
    Input Text    ${LOC_NOM}    ${NOM}
    Input Text    ${LOC_EMAIL}    ' OR '1'='1
    Input Text    ${LOC_PASS}    ${PASSWORD}
    Input Text    ${LOC_CONFIRM}    ${PASSWORD}
    Click Element    ${LOC_BOUTON}
    Page Should Contain    Wrong email
    Page Should Not Contain    Your registration completed
    Log    Succès : L'injection SQL a été bloquée par la validation du format email.

Test 08 : Sécurité - Injection HTML (Tag Injection)
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    <h1>JE_SUIS_LE_PIRATE</h1>
    Input Text    ${LOC_NOM}    <b>Gras</b>
    Input Text    ${LOC_EMAIL}    test.html.inject.01@test.com
    Input Text    ${LOC_PASS}    ${PASSWORD}
    Input Text    ${LOC_CONFIRM}    ${PASSWORD}
    Click Element    ${LOC_BOUTON}
    Page Should Contain    internal error occurred
    Log    Succès : Le serveur a bloqué les balises HTML.

Test 09 : Sécurité - Robustesse (Chaîne très longue)
    Maximize Browser Window
    Set Selenium Speed    0.5s
    ${LONG_TEXT}    Set Variable    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    ${PRENOM}
    Input Text    ${LOC_NOM}    ${LONG_TEXT}
    Input Text    ${LOC_EMAIL}    test.long.string.04@test.com
    Input Text    ${LOC_PASS}    ${PASSWORD}
    Input Text    ${LOC_CONFIRM}    ${PASSWORD}
    Click Element    ${LOC_BOUTON}
    Page Should Contain    internal error occurred
    Log    Succès : Le test a provoqué une erreur serveur (Crash), ce qui démontre une faille de robustesse.

Test 10 : Validation Serveur - Email Déjà Existant (Doublon)
    [Documentation]    CLIENT : On vérifie que le code HTML contient bien les règles de validation (sans envoyer de données).
    Maximize Browser Window
    Set Selenium Speed    0.5s
    ${RANDOM_ID}=    Evaluate    random.randint(1000, 9999)    modules=random
    ${EMAIL_UNIQUE}=    Set Variable    doublon.test.${RANDOM_ID}@test.com
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    Jean
    Input Text    ${LOC_NOM}    Serveur
    Input Text    ${LOC_EMAIL}    ${EMAIL_UNIQUE}
    Input Text    ${LOC_PASS}    ${PASSWORD}
    Input Text    ${LOC_CONFIRM}    ${PASSWORD}
    Click Element    ${LOC_BOUTON}
    Wait Until Page Contains    Your registration completed
    Click Link    Log out
    Click Link    Register
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    Jean
    Input Text    ${LOC_NOM}    Voleur
    Input Text    ${LOC_EMAIL}    ${EMAIL_UNIQUE}
    Input Text    ${LOC_PASS}    ${PASSWORD}
    Input Text    ${LOC_CONFIRM}    ${PASSWORD}
    Click Element    ${LOC_BOUTON}
    Page Should Contain    The specified email already exists
    Log    Succès : Le serveur a bien vérifié dans la base de données que l'email était pris.

Test 11 : Validation Côté Client - Attributs HTML (Adapté)
    Maximize Browser Window
    ${est_obligatoire}=    Get Element Attribute    ${LOC_PRENOM}    data-val-required
    Should Not Be Empty    ${est_obligatoire}
    Log    Succès : Le champ Prénom a bien la règle 'Required'.
    ${regle_email}=    Get Element Attribute    ${LOC_EMAIL}    data-val-email
    Should Not Be Empty    ${regle_email}
    Log    Succès : Le champ Email possède bien une règle de validation javascript (data-val-email).

Test 12 : Validation Côté Serveur - Persistance (Inscription + Login)
    Maximize Browser Window
    Set Selenium Speed    0.5s
    ${RANDOM_ID}=    Evaluate    random.randint(10000, 99999)    modules=random
    ${EMAIL_LOGIN}=    Set Variable    persistance.${RANDOM_ID}@test.com
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    Jean
    Input Text    ${LOC_NOM}    Serveur
    Input Text    ${LOC_EMAIL}    ${EMAIL_LOGIN}
    Input Text    ${LOC_PASS}    ${PASSWORD}
    Input Text    ${LOC_CONFIRM}    ${PASSWORD}
    Click Element    ${LOC_BOUTON}
    Wait Until Page Contains    Your registration completed
    Click Link    Log out
    Click Link    Log in
    Input Text    id:Email    ${EMAIL_LOGIN}
    Input Text    id:Password    ${PASSWORD}
    Click Button    xpath=//input[@value='Log in']
    Page Should Contain    ${EMAIL_LOGIN}
    Log    Succès Serveur : Les données ont été correctement sauvegardées.
    [Teardown]    Close Browser

Test 13 : Validation UX - Clarté des Messages d'Erreur
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Click Element    ${LOC_BOUTON}
    Page Should Contain    First name is required.
    Page Should Contain    Email is required.
    Log    Succès : Messages 'Requis' OK.
    Input Text    ${LOC_EMAIL}    toto
    Click Element    ${LOC_BOUTON}
    Page Should Contain    Wrong email
    Log    Succès : Message 'Format Email' OK.
    Input Text    ${LOC_PASS}    123456
    Input Text    ${LOC_CONFIRM}    654321
    Click Element    ${LOC_BOUTON}
    Page Should Contain    The password and confirmation password do not match.
    Log    Succès : Message 'Incohérence Mots de passe' OK.
    [Teardown]    Close Browser

Test 14 : Performance - Temps de Réponse (Serveur)
    Maximize Browser Window
    ${RANDOM_ID}=    Evaluate    random.randint(1000, 9999)    modules=random
    ${EMAIL_PERF}=    Set Variable    perf.${RANDOM_ID}@test.com
    Click Element    ${LOC_GENRE_M}
    Input Text    ${LOC_PRENOM}    Jean
    Input Text    ${LOC_NOM}    Rapide
    Input Text    ${LOC_EMAIL}    ${EMAIL_PERF}
    Input Text    ${LOC_PASS}    ${PASSWORD}
    Input Text    ${LOC_CONFIRM}    ${PASSWORD}
    ${temps_debut}=    Get Time    epoch
    Click Element    ${LOC_BOUTON}
    Wait Until Page Contains    Your registration completed
    ${temps_fin}=    Get Time    epoch
    ${duree}=    Evaluate    ${temps_fin} - ${temps_debut}
    Log To Console    --------------------------------------
    Log To Console    TEMPS DE RÉPONSE : ${duree} secondes
    Log To Console    --------------------------------------
    Log    Le formulaire a été traité en ${duree} secondes.
    Should Be True    ${duree} < 5
    [Teardown]    Close Browser
