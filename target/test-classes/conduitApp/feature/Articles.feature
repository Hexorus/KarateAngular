Feature: Articles 

Background: Define a Url 
    Given url 'https://api.realworld.io/api/'

Scenario: Create a new article
    Given path 'users/login'
    And request {"user": {"email": "karate@test2.com", "password": "12345"}}
    When method Post
    Then status 200
    #definimos una variable llamada token para almacenar el token que viene en la respuesta del "user:", o tambien de este escenario

    * def token = response.user.token
    
    #aunque en el cursos se muestre el copia y pega del request, la pagina ahora no permite crear articulos similares asi 
    Given path 'articles'
    #que como minimo hay que ir cambiando el titulo
    Given header Authorization = 'Token ' + token 
    And request {"article": {"tagList": [],"title": "blaxdx3","description": "blaxd","body": "blaxd"}} 
    When method Post
    Then status 200

    

