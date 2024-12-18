Feature: Retrieve Activity Logs

  Background:
    # Call the feature file that generates the authorization token
    * def authResponse = call read('../generateToken.feature')
    * def token = authResponse.token
    * print 'Generated Token:', token

  Scenario: Get Activity Logs with Valid Token
    Given url 'https://backend-dev.kentron.ai/api/v1/activity-logs/'
    And param page = 1
    And param page_size = 100
    And param entity = 'Workspace'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer ' + token
    When method get
    Then status 200
    And match response.total == '#number'
    * print 'Response:', karate.pretty(response)

  Scenario: Missing Authorization header
    Given url 'https://backend-dev.kentron.ai/api/v1/activity-logs/'
    And param page = 1
    And param page_size = 100
    And param entity = 'Workspace'
    And header Accept = 'application/json'
    And header Authorization = null
    When method get
    Then status 401
    And response.detail == "Given token not valid for any token type"
    

  Scenario: Invalid Authorization token
    Given url 'https://backend-dev.kentron.ai/api/v1/activity-logs/'
    And param page = 1
    And param page_size = 100
    And param entity = 'Workspace'
    And header Authorization = 'Bearer invalid_token'
    When method get
    Then status 401
    And response.detail == "Given token not valid for any token type"

  Scenario: Invalid entity parameter
    Given url 'https://backend-dev.kentron.ai/api/v1/activity-logs/'
    And param page = 1
    And param page_size = 100
    And param entity = 'InvalidEntity'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer ' + token
    When method get
    Then status 400  
    And response.detail == "Invalid entity value 'Workspace1'. Supported values are: Login, User, Activity Log, Workspace, Tenant Connector Source, Master Connector Source, Connection, Source Type, Shared Workspace, Google Workspace User, Slack Workspace, Jira, Microsoft Teams, Confluence, Generic Connector Filter Data, Generic Connector Data, Attachment."

  Scenario: Invalid page parameter (negative number)
     Given url 'https://backend-dev.kentron.ai/api/v1/activity-logs/'
    And param page = -1
    And param page_size = 100
    And param entity = 'Workspace'
    And header Accept = 'application/json'
    And header Authorization = 'Bearer ' + token
    When method get
    Then status 404
    And response.detail == "Invalid page."