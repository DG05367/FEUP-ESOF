Feature: View My Schedule
    Selecting "Horário" shows the student's schedule

    Scenario: access the "Horário" page
    Given I am logged in
    And I open the drawer
    And I tap the "key_Horário" button
    Then I expect the text "Horário" to be present

    Scenario: View teacher schedule.
    Given I am logged in
    And I open the drawer
    And I tap the "key_Horário" button
    And I tap the "schedule-page-tab-0" button
    And I tap the button that contains the text "LC"
    Then I expect the text "Ver Alternativas" to be present