require 'rails_helper'

feature 'user creates a new account', %(
	As a prospective user
	I want to create an account
	So I can create a pulls list
) do

	# Acceptance Criteria
	# Fill in email and password
	# A new user account is created if the
	# email isn't already in the database
	# Password and password confirmation
	# must match
	# If I fill out the form incorrectly,
	# errors are displayed.

	scenario 'user signs up' do
		visit root_path
		click_link 'Sign up'

		fill_in 'Email', with: 'batman_rules@gmail.com'
		fill_in 'Password', with: 'batcave99', :match => :prefer_exact
		fill_in 'Password confirmation', with: 'batcave99', :match => :prefer_exact
		click_button 'Sign up'

		expect(page).to have_content("Welcome! You have signed up successfully.")

	end

	scenario 'user forgets fields' do
		visit root_path
		click_link 'Sign up'
		click_button 'Sign up'
		expect(page).to have_content("can't be blank")
	end

	scenario 'email already exists' do
		user = User.create(email: 'aquaman@gmail.com',
											 password: 'fisharecool123', password_confirmation: 'fisharecool123')

		visit root_path
		click_link 'Sign up'
		fill_in 'Email', with: 'aquaman@gmail.com'
		fill_in 'Password', with: 'secret123', :match => :prefer_exact
		fill_in 'Password confirmation', with: 'secret123', :match => :prefer_exact
		click_button 'Sign up'

		expect(page).to have_content('has already been taken')
	end

	scenario 'passwords do not match' do
		visit root_path
		click_link 'Sign up'

		fill_in 'Email', with: 'captian_america_king@gmail.com'
		fill_in 'Password', with: '12345678', :match => :prefer_exact
		fill_in 'Password confirmation', with: '87654321', :match => :prefer_exact
		click_button 'Sign up'

		expect(page).to have_content("Password confirmationdoesn't match")
	end
end
