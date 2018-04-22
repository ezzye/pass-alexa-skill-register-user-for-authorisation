# Created by ellioe03 at 30/11/2017
Feature: Intent Processing
  Testing the behaviour of all intents

  Scenario Outline: Intent with Slots Behaviour
    Given question can be obtained from REST interface
    And shared secret can be obtained from REST interface
    When handler receives a "<intentName>" intent
    Then handler should give response from a "<intentNameResponse>" and output speech "<output>"
    Examples:
      | intentName | intentNameResponse | output                                                              |
      | launch     | launchresponse     | welcome to password checker, what user name do you want to register |
      | register   | registerresponse   | are you alone                                                       |
      | animal     | animalresponse     | animal question                                                           |