# Deprecation notice from the original web-steps:
#
# This file was generated by Cucumber-Rails and is only here to get you a head start
# These step definitions are thin wrappers around the Capybara/Webrat API that lets you
# visit pages, interact with widgets and make assertions about page content.
#
# If you use these step definitions as basis for your features you will quickly end up
# with features that are:
#
# * Hard to maintain
# * Verbose to read
#
# A much better approach is to write your own higher level step definitions, following
# the advice in the following blog posts:
#
# * http://benmabey.com/2008/05/19/imperative-vs-declarative-scenarios-in-user-stories.html
# * http://dannorth.net/2011/01/31/whose-domain-is-it-anyway/
# * http://elabs.se/blog/15-you-re-cuking-it-wrong
#

require 'spreewald_support/tolerance_for_selenium_sync_issues'
require 'spreewald_support/path_selector_fallbacks'
require 'uri'
require 'cgi'

# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |nested_step, parent|
  with_scope(parent) { step(nested_step) }
end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |nested_step, parent, table_or_string|
  with_scope(parent) { step("#{nested_step}:", table_or_string) }
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit _path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit _path_to(page_name)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  patiently do
    click_button(button)
  end
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  patiently do
    click_link(link)
  end
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  patiently do
    fill_in(field, :with => value)
  end
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  patiently do
    fill_in(field, :with => value)
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  patiently do
    select(value, :from => field)
  end
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  patiently do
    check(field)
  end
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  patiently do
    uncheck(field)
  end
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  patiently do
    choose(field)
  end
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  patiently do
    attach_file(field, File.expand_path(path))
  end
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  patiently do
    page.should have_content(text)
  end
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  patiently do
    page.should have_xpath('//*', :text => regexp)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  patiently do
    page.should have_no_content(text)
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  patiently do
    regexp = Regexp.new(regexp)
    page.should have_no_xpath('//*', :text => regexp)
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  patiently do
    with_scope(parent) do
      field = find_field(field)
      field_value = (field.tag_name == 'textarea') ? field.text : field.value
      field_value.should =~ /#{value}/
    end
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
  patiently do
    with_scope(parent) do
      field = find_field(field)
      field_value = (field.tag_name == 'textarea') ? field.text : field.value
      field_value.should_not =~ /#{value}/
    end
  end
end

Then /^the "([^"]*)" field should have the error "([^"]*)"$/ do |field, error_message|
  patiently do
    element = find_field(field)
    classes = element.find(:xpath, '..')[:class].split(' ')

    form_for_input = element.find(:xpath, 'ancestor::form[1]')
    using_formtastic = form_for_input[:class].include?('formtastic')
    error_class = using_formtastic ? 'error' : 'field_with_errors'

    classes.should include(error_class)

    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      error_paragraph.should have_content(error_message)
    else
      page.should have_content("#{field.titlecase} #{error_message}")
    end
  end
end

Then /^the "([^"]*)" field should have no error$/ do |field|
  patiently do
    element = find_field(field)
    classes = element.find(:xpath, '..')[:class].split(' ')
    classes.should_not include('field_with_errors')
    classes.should_not include('error')
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
  patiently do
    with_scope(parent) do
      field_checked = find_field(label)['checked']
      field_checked.should be_true
    end
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
  patiently do
    with_scope(parent) do
      field_checked = find_field(label)['checked']
      field_checked.should be_false
    end
  end
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  patiently do
    current_path = URI.parse(current_url).path
    current_path.should == _path_to(page_name)
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  patiently do
    query = URI.parse(current_url).query
    actual_params = query ? CGI.parse(query) : {}
    expected_params = {}
    expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}

    actual_params.should == expected_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end


Then /^I should( not)? see a field "([^"]*)"$/ do |negate, name|
  expectation = negate ? :should_not : :should
  patiently do
    begin
      field = find_field(name)
    rescue Capybara::ElementNotFound
      # In Capybara 0.4+ #find_field raises an error instead of returning nil
    end
    field.send(expectation, be_present)
  end
end

Then /^I should( not)? see the (?:number|amount) ([\-\d,\.]+)(?: (.*?))?$/ do |negate, amount, unit|
  no_minus = amount.starts_with?('-') ? '' : '[^\\-]'
  nbsp = 0xC2.chr + 0xA0.chr
  regexp = Regexp.new(no_minus + "\\b" + Regexp.quote(amount) + (unit ? "( |#{nbsp}|&nbsp;)(#{unit}|#{Regexp.quote(HTMLEntities.new.encode(unit, :named))})" :"\\b"))
  expectation = negate ? :should_not : :should
  patiently do
    page.body.send(expectation, match(regexp))
  end
end

Then /^I should get a response with content-type "([^\"]*)"$/ do |expected_content_type|
  page.response_headers['Content-Type'].should =~ /\A#{Regexp.quote(expected_content_type)}($|;)/
end

Then /^I should get a download with filename "([^\"]*)"$/ do |filename|
  page.response_headers['Content-Disposition'].should =~ /filename="#{filename}"$/
end


Then /^"([^"]*)" should be selected for "([^"]*)"(?: within "([^\"]*)")?$/ do |value, field, selector|
  patiently do
    with_scope(selector) do
      field_labeled(field).find(:xpath, ".//option[@selected = 'selected'][text() = '#{value}']").should be_present
    end
  end
end

Then /^nothing should be selected for "([^"]*)"?$/ do |field|
  patiently do
    select = find_field(field)
    select.should_not have_css('option[selected]')
  end
end

Then /^"([^"]*)" should( not)? be an option for "([^"]*)"(?: within "([^\"]*)")?$/ do |value, negate, field, selector|
  patiently do
    with_scope(selector) do
      expectation = negate ? :should_not : :should
      field_labeled(field).first(:xpath, ".//option[text() = '#{value}']").send(expectation, be_present)
    end
  end
end

Then /^(?:|I )should see '([^']*)'(?: within '([^']*)')?$/ do |text, selector|
  patiently do
    with_scope(selector) do
      page.should have_content(text)
    end
  end
end

Then /^I should see "([^\"]*)" in the HTML$/ do |text|
  patiently do
    page.body.should include(text)
  end
end

Then /^I should not see "([^\"]*)" in the HTML$/ do |text|
  patiently do
    page.body.should_not include(text)
  end
end

Then /^I should see an error$/ do
  (400 .. 599).should include(page.status_code)
end

Then /^the window should be titled "([^"]*)"$/ do |title|
  page.should have_css('title', :text => title)
end

When /^I reload the page$/ do
  visit current_path
end

Then /^"([^\"]+)" should( not)? be visible$/ do |text, negate|
  paths = [
    "//*[@class='hidden']/*[contains(.,'#{text}')]",
    "//*[@class='invisible']/*[contains(.,'#{text}')]",
    "//*[@style='display: none;']/*[contains(.,'#{text}')]"
  ]
  xpath = paths.join '|'
  expectation = negate ? :should : :should_not
  patiently do
    page.send(expectation, have_xpath(xpath))
  end
end

When /^I click on "([^\"]+)"$/ do |text|
  matcher = ['*', { :text => text }]
  patiently do
    element = page.find(:css, *matcher)
    while better_match = element.first(:css, *matcher)
      element = better_match
    end
    element.click
  end
end

Then /^I should (not )?see an element "([^"]*)"$/ do |negate, selector|
  expectation = negate ? :should_not : :should
  patiently do
    page.send(expectation, have_css(selector))
  end
end

Then /^I should get a text response$/ do
  step 'I should get a response with content-type "text/plain"'
end
