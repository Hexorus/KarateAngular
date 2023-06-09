@graphql_examples @run
Feature: users

Background:
* url 'https://graphqlzero.almansi.me/api'
# this live url should work if you want to try this on your own

@graphql_zero
Scenario: simple graphql request
    # note the use of text instead of def since this is NOT json
    Given text query =
    """
    {
      user(id: 1) {
        posts {
          data {
            id
            title
          }
        }
      }
    }
    """
    And request { query: '#(query)' }
    When method post
    Then status 200

    # pretty print the response
    * print 'response:', response

    # json-path makes it easy to focus only on the parts you are interested in
    # which is especially useful for graph-ql as responses tend to be heavily nested
    # '$' happens to be a JsonPath-friendly short-cut for the 'response' variable
    * match $.data.user.posts.data[0] contains { id: '1' }

    # the '..' wildcard is useful for traversing deeply nested parts of the json
    * def posts = $..posts.data[*]
    * match posts[1] == { id: '2', title: 'qui est esse' }

@graphql_zero
Scenario Outline: graphql query from a file and using examples - <username>
    # here the query is read from a file
    # note that the 'replace' keyword (not used here) can also be very useful for dynamic query building
    Given def query = read('./queries/user-by-id.graphql')
    And request { query: '#(query)', variables: '#(<variables>)' }
    When method post
    Then status 200
    And match response..username contains "<username>"
    And match response.data.user.address == <address>

Examples:
    # The third example has the wrong "lng" field only for testing purposes
    | variables | username  | address                                |
    | { id: 1 } | Bret      | { geo:{ lng: 81.1496, lat: -37.3159 } }|
    | { id: 2 } | Antonette | { geo:{ lat:-43.9509, lng: -34.4618 } }|
    | { id: 3 } | Samantha  | { geo:{ lat:-68.6102, lng: -47.0653 } }|
