Feature: See class schedule
  Selecting a class makes it's schedule appear.

  Scenario: access the class schedule list page
    When I open the drawer
    And I tap the "key_Horário de Disciplinas" button
    Then I expect the text "Disciplinas" to be present


  Scenario Outline: choose a class and access its schedule
    When I open the drawer
    And I tap the "key_Horário de Disciplinas" button
    And I tap the widget that contains the text <className>
    Then I expect the text <className> to be present

    Examples:
    |       className        |
    | "Engenharia de Software" |
    | "Desenho de Algoritmos"  |

  Scenario Outline: return to the class schedule list after choosing a class
    When I open the drawer
    And I tap the "key_Horário de Disciplinas" button
    And I tap the widget that contains the text <className>
    And I tap the back button
    Then I expect the text "Disciplinas" to be present

    Examples:
    |       className        |
    | "Engenharia de Software" |
    | "Desenho de Algoritmos"  |
