# Created by ellioe03 at 08/01/2018
@WIP
Feature: Play radio stations
  # Alexa to give appropriate responses when asked to play a radio station

  Scenario Outline: Alexa makes appropriate response given a request
    When <conversation> called
    Then skill response appropriately for each point in context
    Examples:
      | conversation                                                 |
      | To play a radio station - when the skill is not already open |