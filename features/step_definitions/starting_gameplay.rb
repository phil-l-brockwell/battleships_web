Given(/^I am on enter_name page$/) do
  visit('/enter_name')
end

When(/^I provide "(.*?)" name and click "(.*?)"$/) do |arg1, arg2|
  fill_in(arg1, with: "Player1")
  click_button(arg2)
end

Then(/^I should see the board$/) do
  expect(page).to have_content('board')
end