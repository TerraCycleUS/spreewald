# Spreewald

Spreewald is a collection of useful steps for cucumber. Feel free to fork.

## Installation

Add this line to your application's Gemfile:

    gem 'spreewald'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spreewald

## Usage

Steps are grouped into a number of categories. You can pick and choose single categories by putting something like

    require 'spreewald/email_steps'

into either your `support/env.rb` or a `step_defitions/spreewald_steps.rb`.

Alternatively, you can require everything by doing

    require 'spreewald/all_steps'


## Waiting for page load

Spreewald's web steps are all aware that you might run them with a Selenium/Capybara webdriver, and wait for the browser to finish loading the page, if necessary.

This is done by rerunning any assertions until they suceed or a timeout is reached.

We consider a couple of potential exceptions as "retriable", including
    Capybara::ElementNotFound, (R)Spec::Expectations::ExpectationNotMetError, Capybara::Poltergeist::ClickFailed

You can add your own error class with
    ToleranceForSeleniumSyncIssues::RETRY_ERRORS << 'MyCustomError'

You can achieve this in your own steps by wrapping them inside a `patiently do` block, like

    Then /^I should see "([^\"]*)" in the HTML$/ do |text|
      patiently do
        page.body.should include(text)
      end
    end

More info [here](https://makandracards.com/makandra/12139-waiting-for-page-load-with-spreewald).

## This README

The "Steps" section is autogenerated by `rake update_readme` from comments in the step definitions.


## Steps

### development_steps.rb



* **Then it should work**

  Marks scenario as pending


* **Then debugger**

  Starts debugger, or Pry if installed


* **@slow**

  Waits 2 seconds after each step


* **@single**

  Waits for keypress after each step



### email_steps.rb



* **When I clear my e?mails**

  


* **Then (an|no) e?mail should have been sent with:**

  Example:
  
        Then an email should have been sent with:
          """
          From: max.mustermann@example.com
          Reply-To: mmuster@gmail.com
          To: john.doe@example.com
          Subject: The subject may contain "quotes"
          Attachments: ...
  
          Message body goes here.
          """
  
  You can skip lines, of course. Note that the mail body is only checked for
  _inclusion_.


* **When I follow the (first|second|third)? link in the e?mail**

  Only works after you have retrieved the mail using "Then an email should have been sent with:"


* **Then no e?mail should have been sent**

  


* **Then I should see "..." in the e?mail**

  Checks that the last sent email includes some text


* **Then show me the e?mails**

  Print all sent emails to STDOUT.


* **Then that e?mail should( not)? have the following lines in the body:**

  Only works after you've retrieved the email using "Then an email should have been sent with:"
  
  Example:
  
        And that mail should have the following lines in the body:
          """
          All of these lines
          need to be present
          """


* **Then that e?mail should have the following body:**

  Only works after you've retrieved the email using "Then an email should have been sent with:"
  Checks that the text should be included in the retrieved email



### file_attachment_steps.rb



* **Given the file "..." was attached( as (.../)?...)? to the ... above( at "...")?**

  Attach a file to the given ActiveRecord model's last record.
  
  Example (Company has a `file` attribute):
  
      Given the file "image.png" was attached to the company above
  
  You may specify the attribute under which the file is stored …
  
  Example (Company has a `logo` attribute):
  
      Given the file "image.png" was attached as logo to the company above
  
  … or both a container class and its attribute name
  
  Example (Company has many `Image`s, `Image` has a `file` attribute)
  
      Given the file "image.png" was attached as Image/file to the company above
  
  To simultaneously set the `updated_at` timestamp:
  
      Given the file "some_file" was attached to the profile above at "2011-11-11 11:11"




### table_steps.rb



* **Then I should( not)? see a table with (exactly )?the following rows( in any order)?**

  Check the content of tables in your HTML.
  
  See [this article](https://makandracards.com/makandra/763-cucumber-step-to-match-table-rows-with-capybara) for details.



### timecop_steps.rb

Steps to travel through time using [Timecop](https://github.com/jtrupiano/timecop).

See [this article](https://makandracards.com/makandra/1222-useful-cucumber-steps-to-travel-through-time-with-timecop) for details.


* **When the (date|time) is "?(\d{4}-\d{2}-\d{2}( \d{1,2}:\d{2})?)"?**

  Example:
  
        Given the date is 2012-02-10
        Given the time is 2012-02-10 13:40


* **When the time is "?(\d{1,2}:\d{2})"?**

  Example:
  
        Given the time is 13:40


* **When it is (\d+|a|some|a few) (seconds?|minutes?|hours?|days?|weeks?|months?|years?) (later|earlier)**

  Example:
  
        When it is 10 minutes later
        When it is a few hours earlier



### web_steps.rb

Most of cucumber-rails' original web steps plus a few of our own. 

Note that cucumber-rails deprecated all its steps quite a while ago with the following
deprecation notice. Decide for yourself whether you want to use them:

> This file was generated by Cucumber-Rails and is only here to get you a head start
> These step definitions are thin wrappers around the Capybara/Webrat API that lets you
> visit pages, interact with widgets and make assertions about page content.

> If you use these step definitions as basis for your features you will quickly end up
> with features that are:

> * Hard to maintain
> * Verbose to read

> A much better approach is to write your own higher level step definitions, following
> the advice in the following blog posts:

> * http://benmabey.com/2008/05/19/imperative-vs-declarative-scenarios-in-user-stories.html
> * http://dannorth.net/2011/01/31/whose-domain-is-it-anyway/
> * http://elabs.se/blog/15-you-re-cuking-it-wrong



* **When ... within (.*[^:])**

  You can append `within [selector]` to any other web step
  
  Example:
  
        Then I should see "some text" within ".page_body"


* **Given I am on ...**

  


* **When I go to ...**

  


* **Then I should be on ...**

  


* **When I press "..."**

  


* **When I follow "..."**

  


* **When I fill in "..." (with|for) "..."**

  Fill in text field


* **When I fill in "..." (with|for) '...'**

  Fill in text field


* **When I select "..." from "..."**

  Select from select box


* **When I check "..."**

  Check a checkbox


* **When I uncheck "..."**

  Uncheck a checkbox


* **When I choose "..."**

  Select a radio button


* **When I attach the file "..." to "..."**

  Attach a file to a file upload form field


* **Then I should see "..."**

  Checks that some text appears on the page
  
  Note that this does not detect if the text might be hidden via CSS


* **Then I should see /([^/]*)/**

  Checks that a regexp appears on the page
  
  Note that this does not detect if the text might be hidden via CSS


* **Then I should not see "..."**

  


* **Then I should not see /([^/]*)/**

  


* **Then the "..." field should (not )?contain "..."**

  Checks that an input field contains some value (allowing * as wildcard character)


* **Then(the "(.*?)" field should (not )?contain:)**

  Checks that a multiline textarea contains some value (allowing * as wildcard character)


* **Then I should see a form with the following values:**

  Checks that a list of label/value pairs are visible as control inputs.
  
  Example:
  
        Then I should see a form with the following values:
          | E-mail | foo@bar.com   |
          | Role   | Administrator |



* **Then the "..." field should have the error "..."**

  Checks that an input field was wrapped with a validation error


* **Then the "..." field should( not)? have an error**

  


* **Then the "..." field should have no error**

  


* **Then the radio button "..." should( not)? be (checked|selected)**

  


* **Then I should have the following query string:**

  Example:
  
        I should have the following query string:
          | locale        | de  |
          | currency_code | EUR |
  
  Succeeds when the URL contains the given `locale` and `currency_code` params


* **Then show me the page**

  Open the current Capybara page using the `launchy` gem


* **Then I should( not)? see a field "..."**

  Checks for the existance of an input field (given its id or label)


* **Then I should( not)? see the (number|amount) ([\-\d,\.]+)( (.*?))?**

  Use this step to test for a number or money amount instead of a simple `Then I should see`
  
  Checks for an unexpected minus sign, correct decimal places etc.
  
  See [here](https://makandracards.com/makandra/1225-test-that-a-number-or-money-amount-is-shown-with-cucumber) for details


* **Then I should get a response with content-type "..."**

  Checks `Content-Type` HTTP header


* **Then I should get a download with filename "..."**

  Checks `Content-Disposition` HTTP header
  
  Attention: Doesn't work with Selenium, see https://github.com/jnicklas/capybara#gotchas


* **Then "..." should be selected for "..."**

  Checks that a certain option is selected for a text field


* **Then nothing should be selected for "..."?**

  


* **Then "..." should( not)? be an option for "..."**

  Checks for the presence of an option in a select


* **Then I should see '([^']*)'**

  Like `Then I should see`, but with single instead of double quotes. In case
  the expected string contains quotes as well.


* **Then I should see "..." in the HTML**

  Check that the raw HTML contains a string


* **Then I should not see "..." in the HTML**

  


* **Then I should see an error**

  Checks that status code is 400..599


* **When I reload the page**

  


* **Then (the tag )?"..." should( not)? be visible**

  Checks that an element is actually visible, also considering styles
  Within a selenium test, the browser is asked whether the element is really visible
  In a non-selenium test, we only check for `.hidden`, `.invisible` or `style: display:none`
  
  More details [here](https://makandracards.com/makandra/1049-capybara-check-that-a-page-element-is-hidden-via-css)


* **When I click on "..."**

  Click on some text that might not be a link


* **Then "..." should link to "..."**

  Use this step to check external links.
  
  Example:
  
        Then "Sponsor" should link to "http://makandra.com"



* **Then I should (not )?see an element "..."**

  Example:
  
        Then I should see an element ".page .container"



* **Then I should get a text response**

  Checks that the result has content type `text/plain`


* **When I follow "..." inside any "..."**

  Click a link within an element matching the given selector. Will try to be clever
  and disregard elements that don't contain a matching link.
  
  Example:
  
        When I follow "Read more" inside any ".text_snippet"



* **Then I should( not)? see "..." inside any "..."**

  


* **When I fill in "..." with "..." inside any "..."**

  


* **When I confirm the browser dialog**

  


* **When I cancel the browser dialog**

  


* **When I enter "..." into the browser dialog**

  


* **When I switch to the new tab**

  


* **Then I should see in this order:?**

  Checks that these strings are rendered in the given order in a single line or in multiple lines
  
  Example:
  
        Then I should see in this order:
          | Alpha Group |
          | Augsburg    |
          | Berlin      |
          | Beta Group  |



* **Then the "..." (field|button) should( not)? be disabled**

  Tests that an input or button with the given label is disabled.


* **Then the "..." field should( not)? be visible**

  Tests that a field with the given label is visible.


* **When I wait for the page to load**

  Waits for the page to finish loading and AJAX requests to finish.
  
  More details [here](https://makandracards.com/makandra/12139-waiting-for-page-loads-and-ajax-requests-to-finish-with-capybara).


* **When I perform basic authentication as ".../..." and go to ...**

  Performs HTTP basic authentication with the given credentials and visits the given path.
  
  More details [here](https://makandracards.com/makandra/971-perform-http-basic-authentication-in-cucumber).


* **When I go back**

  Go to the previously viewed page.

