Feature: See class personal schedule
  Selecting a class makes it's schedule appear.

  Scenario: access my personal schedule page
    When I open the drawer
    And I tap the "key_Horário Pessoal" button
    Then I expect the text "Segunda-feira" to be present

  Scenario Outline: access the class schedule list page
    When I open the drawer
    And I tap the "key_Horário" button
    And I tap the "schedule-page-tab-2" button
    And I tap the "schedule-page-tab-1" button
    And I tap the widget that contains the text <className>
    Then I expect the text "Ver Horário" to be present

    Examples:
      |       className        |
      |         "SO"           |
      |         "LC"           |