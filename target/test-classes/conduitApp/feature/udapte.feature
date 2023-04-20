Feature: Articles 

Background: Define a Url 
    Given url 'https://api.realworld.io/api/'

Scenario: Create a new article
    Given path 'users/login'
    And request {"user": {"email": "karate@test2.com", "password": "12345"}}
    When method Post
    Then status 200