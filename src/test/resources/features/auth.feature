Feature: Sample API Test

Scenario: Successful Login with Valid Credentials
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
    When method POST
    Then status 200
    And response.error == false
    And response.message == "Login Success"

Scenario: Unsuccessful Login with Invalid Credentials
    Given url 'https://backend-dev.kentron.ai/api/v1/auth/login/'
    And header Content-Type = 'application/json'
    And request 
    """
    {
        "email": "invalid_user",
        "password": "wrong_password",
        "tenant_name": "abc"
    }
    """
    When method post
    Then status 400
    And response.errors != null
    And response.errors.email[0] == "Enter a valid email address."

  Scenario: Login with Missing Fields
    Given url 'https://backend-dev.kentron.ai/api/v1/auth/login/'
    And header Content-Type = 'application/json'
    And request 
    """
    {
        "email": "",
        "password": "",
        "tenant_name": ""
    }
    """
    When method post
    Then status 400
    Then status 400
    And response.errors != null   
    And response.errors.tenant_name[0] == "This field may not be blank."
    And response.errors.email[0] == "This field may not be blank."
    And response.errors.password[0] == "This field may not be blank."
