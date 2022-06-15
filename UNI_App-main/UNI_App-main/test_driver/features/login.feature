Feature: Open pages
  The pages should appear when we click on the respective menu options

  Scenario: login and access the main page
    Given I am logged in
    And I open the drawer
    And I tap the "key_Área Pessoal" button
    Then I expect the text "Área Pessoal" to be present
#
#
  #Scenario: login and access the "Horário" page
  #  Given I am logged in
  #  And I open the drawer
  #  And I tap the "key_Horário" button
  #  Then I expect the text "Horário" to be present
#
  #Scenario: login and access the "Mapa de Exames" page
  #  Given I am logged in
  #  And I open the drawer
  #  And I tap the "key_Mapa de Exames" button
  #  Then I expect the text "Exames" to be present
#
  #Scenario: login and access the "Autocarros" page
  #  Given I am logged in
  #  And I open the drawer
  #  And I tap the "key_Autocarros" button
  #  Then I expect the text "Autocarros" to be present

  #Scenario: submit bug report
  #  Given I am logged in
  #  And I open the drawer
  #  And I tap the "key_Bugs e Sugestões" button
  #  And I fill the "key_bug_form_Título" field with "Texto 1"
  #  And I fill the "key_bug_form_Descrição" field with "Texto 2"
  #  And I pause for 1 seconds
  #  And I tap the "key_bug_consent" button
  #  And I pause for 1 seconds
  #  And I tap the "key_bug_form_submit" button
  #  And I pause for 1 seconds
  #  Then I expect the text "Texto 1" to be absent

