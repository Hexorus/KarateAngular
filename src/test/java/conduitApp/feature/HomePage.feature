Feature: test for the homepage

Background: Define a URL
    Given url 'https://api.realworld.io/api/'

#Karate zero to hero

Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains  ['welcome', 'introduction']
#verificar que la respuesta tenga ciertos elementos del arreglo  (1)
    And match response.tags !contains 'truck'
#verificar que la respuesta no devuelva el elemento especificado (!) funcionando como negacion (1)
    And match response.tags == "#array"
#verificamos que la respuesta sea un "array" (arreglo) (1)
    And match each response.tags == "#string" 
#verificamos que cada miembro del arreglo tags sea de tipo "string" (cadena) (1)


Scenario: Get 10 articles 
    Given params { limit :10, offset : 0}
    Given path 'articles'
#Given param limit = 10 ejemplo de refactorizacion
#Given param offset = 0 ejemplo de refactorizacion
    When method Get
    Then status 200
    And match response.articles == '#[10]'
#verificar que la cantidad de articulos en el arreglo sea la especificada previamente (limit = 10) (1)
    And match response.articlesCount == 197
#Verificamos que el total de articulos sea el que especificamos (1)


# (1) aserciones 

#el token se obtiene haciendo un reloggin usando el inspeccionador de elementos 
