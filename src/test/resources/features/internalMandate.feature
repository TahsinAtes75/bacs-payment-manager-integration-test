@feature @runner
Feature: BACSM - Internal Mandate
  In case Customer or Agent initiated a mandate request


  Background:
    Given I set global values from properties file at "properties/globalValues.properties"
    And I set REST API url as "base_url_test"
    And I set request header content type as JSON


    #  jwt cases ##

  @BANK-5212 @BANK-5365 @BANK-5212_1 @negative
  Scenario: jwt - token belonged to another customer
    And I have been authenticated at "security_manager_customer_login_endpoint_test" with information given in the following json
    """
      {
        "email": "aslihan@yopmail.com",
        "password": "123456"
      }
    """
    And I have stored token from path "token"
    And I have added value token in key "Authorization" at header
    And I set request body with information given in the following json
    """
      {
        "debtorAccount": {
          "accountName": "alpaslan turk",
          "accountNumber": "63318164",
          "sortCode": "010035"
        },
        "originatorName": "TMobile",
        "reference": "reference 1",
        "serviceUserNumber": "030201"
      }
    """
    And I set path parameter "subscription-key" with value "07538be8-3e3c-3e6a-965e-91b4c774e505"
    When I POST request to "internal-mandate_endpoint"
    Then response status code should be 401
    And response body should be following json
    """
      {
        "errors": [
          {
            "code": "7014",
            "description": "Unauthorized token"
          }
        ]
      }
    """


  @BANK-5212 @BANK-5365 @BANK-5212_2 @negative
  Scenario: jwt - expired token
    And I set header "Authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMDliMjhiMi1jYjAwLTRjNzUtYjA1NS1kMTIzZTA3NjNiZGIiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4MzcwMTZiMi00ZDA0LTRiNzYtODNiNi0xYWYyY2QxYThiNzAiLCJzY29wZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjAwNDM3NTU4LCJleHAiOjYwMTA0MjM1OH0.vouarK6JMVZ-0MYk8iEnQxTLU1qsy-p3Cw3DYDgFCCJ0ly4XcBzklnDgPK7R51EYvIG0cepAbVZt6TyNFgJrdA"
    And I set request body with information given in the following json
    """
      {
        "debtorAccount": {
          "accountName": "alpaslan turk",
          "accountNumber": "63318164",
          "sortCode": "010035"
        },
        "originatorName": "TMobile",
        "reference": "reference 1",
        "serviceUserNumber": "030201"
      }
    """
    And I set path parameter "subscription-key" with value "07538be8-3e3c-3e6a-965e-91b4c774e505"
    When I POST request to "internal-mandate_endpoint"
    Then response status code should be 401
    And response body should be following json
    """
      {
        "errors": [
          {
            "code": "7016",
            "description": "Expired token"
          }
        ]
      }
    """


  @BANK-5212 @BANK-5365 @BANK-5212_3 @negative
  Scenario: jwt - invalid token
    And I set header "Authorization" parameter with value "xyz"
    And I set request body with information given in the following json
    """
      {
        "debtorAccount": {
          "accountName": "alpaslan turk",
          "accountNumber": "63318164",
          "sortCode": "010035"
        },
        "originatorName": "TMobile",
        "reference": "reference 1",
        "serviceUserNumber": "030201"
      }
    """
    And I set path parameter "subscription-key" with value "07538be8-3e3c-3e6a-965e-91b4c774e505"
    When I POST request to "internal-mandate_endpoint"
    Then response status code should be 401
    And response body should be following json
    """
      {
        "errors": [
          {
            "code": "7017",
            "description": "Invalid token"
          }
        ]
      }
    """


  @BANK-5212 @BANK-5365 @BANK-5212_4 @negative
  Scenario: jwt - token with a type other than "CUSTOMER" or "AGENT"
    And I set header "Authorization" parameter with value "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI3OTU0ODgyOC1hN2NjLTQxYzctYTZiNy01NWYwOTA3ODY0MzYiLCJpc3MiOiJIeW1uYWkiLCJzdWIiOiI4MzcwMTZiMi00ZDA0LTRiNzYtODNiNi0xYWYyY2QxYThiNzAiLCJzY29wZSI6Ik9USEVSIiwiaWF0IjoxNjAwNDM5NDQ3LCJleHAiOjE3MDEwNDQyNDd9.a8ofgx_ClvYNtQ2XADGEk-7Uu1qa9Hl_aY03aKy9Relsfn9S4bJB_brN6-hRB3VoAIC9VQi9fgZfftB3UhJ7Tw"
    And I set request body with information given in the following json
    """
      {
        "debtorAccount": {
          "accountName": "alpaslan turk",
          "accountNumber": "63318164",
          "sortCode": "010035"
        },
        "originatorName": "TMobile",
        "reference": "reference 1",
        "serviceUserNumber": "030201"
      }
    """
    And I set path parameter "subscription-key" with value "07538be8-3e3c-3e6a-965e-91b4c774e505"
    When I POST request to "internal-mandate_endpoint"
    Then response status code should be 401
    And response body should be following json
    """
      {
        "errors": [
          {
            "code": "7014",
            "description": "Unauthorized token"
          }
        ]
      }
    """



  #  field validations ##

  @BANK-5212 @BANK-5365 @BANK-5212_5 @negative
  Scenario: When the "Authorization" header parameter is empty
    And I set header "Authorization" parameter with value ""
    And I set request body with information given in the following json
    """
      {
        "debtorAccount": {
          "accountName": "alpaslan turk",
          "accountNumber": "63318164",
          "sortCode": "010035"
        },
        "originatorName": "TMobile",
        "reference": "reference 1",
        "serviceUserNumber": "030201"
      }
    """
    And I set path parameter "subscription-key" with value "07538be8-3e3c-3e6a-965e-91b4c774e505"
    When I POST request to "internal-mandate_endpoint"
    Then response status code should be 400
    And response body should be following json
    """
      {
        "errors": [
          {
            "code": "7015",
            "description": "Token must be provided"
          }
        ]
      }
    """


  @BANK-5212 @BANK-5365 @BANK-5212_6 @negative
  Scenario: When there is invalid (non-existent) subscription-key
    And I have been authenticated at "security_manager_customer_login_endpoint_test" with information given in the following json
    """
      {
        "email": "alpaslan@yopmail.com",
        "password": "123456"
      }
    """
    And I have stored token from path "token"
    And I have added value token in key "Authorization" at header
    And I set request body with information given in the following json
    """
      {
        "debtorAccount": {
          "accountName": "alpaslan turk",
          "accountNumber": "63318164",
          "sortCode": "010035"
        },
        "originatorName": "TMobile",
        "reference": "reference 1",
        "serviceUserNumber": "030201"
      }
    """
    And I set path parameter "subscription-key" with value "07538be8-3e3c-3e6a-965e-91b4c774e506"
    When I POST request to "internal-mandate_endpoint"
    And response status code should be 400
    And response body should be following json
    """
      {
        "errors": [
          {
            "code": "7019",
            "description": "Given subscription key is invalid",
            "field":"subscriptionKey"
          }
        ]
      }
    """


  @BANK-5212 @BANK-5365 @BANK-5212_7 @negative
  Scenario: Debtor account number is wrong
    And I have been authenticated at "security_manager_customer_login_endpoint_test" with information given in the following json
    """
      {
        "email": "alpaslan@yopmail.com",
        "password": "123456"
      }
    """
    And I have stored token from path "token"
    And I have added value token in key "Authorization" at header
    And I set request body with information given in the following json
    """
      {
        "debtorAccount": {
          "accountName": "alpaslan turk",
          "accountNumber": "63318165",
          "sortCode": "010035"
        },
        "originatorName": "TMobile",
        "reference": "reference 1",
        "serviceUserNumber": "030201"
      }
    """
    And I set path parameter "subscription-key" with value "07538be8-3e3c-3e6a-965e-91b4c774e505"
    When I POST request to "internal-mandate_endpoint"
    And response status code should be 404
    And response body should be following json
    """
      {
        "errors": [
          {
            "code": "7007",
            "description": "Debtor account not found"
          }
        ]
      }
    """


  @BANK-5212 @BANK-5365 @BANK-5212_8 @negative
  Scenario: Debtor sort code is wrong
    And I have been authenticated at "security_manager_customer_login_endpoint_test" with information given in the following json
    """
      {
        "email": "alpaslan@yopmail.com",
        "password": "123456"
      }
    """
    And I have stored token from path "token"
    And I have added value token in key "Authorization" at header
    And I set request body with information given in the following json
    """
      {
        "debtorAccount": {
          "accountName": "alpaslan turk",
          "accountNumber": "63318164",
          "sortCode": "010036"
        },
        "originatorName": "TMobile",
        "reference": "reference 1",
        "serviceUserNumber": "030201"
      }
    """
    And I set path parameter "subscription-key" with value "07538be8-3e3c-3e6a-965e-91b4c774e505"
    When I POST request to "internal-mandate_endpoint"
    And response status code should be 404
    And response body should be following json
    """
      {
        "errors": [
          {
            "code": "7007",
            "description": "Debtor account not found"
          }
        ]
      }
    """




