Feature: Generate Authorization Token

  Scenario: Generate Bearer Token
    Given url 'https://backend-dev.kentron.ai/api/v1/auth/login/'
    And header Content-Type = 'application/json'
    And request 
    """
    {
        "email": "dishant@mangotech.com",
        "password": "hello",
        "tenant_name": "mangotech"
    }
    """
    When method post
    Then status 200
    And match response.data.access != null
    * def token = response.data.access
    * print 'Generated Token:', token
