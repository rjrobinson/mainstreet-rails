require 'rails_helper'

feature 'user creates a new account', %(
	As a prospective user
	I want to create an account
	So I can create a pulls list
) do


	scenario 'user signs up' do
		visit root_path
		click_link 'Sign up'
		# Fill in information, and sign up.
		fill_in 'Email', with: 'justatest@gmail.com'
		fill_in 'Password', with: 'test12345', :match => :prefer_exact
		fill_in 'Password confirmation', with: 'test12345', :match => :prefer_exact

		click_button 'Sign up'
		expect(page).to have_content("A message with a confirmation link has been sent to your email address.")
		# An email will be generated, and sent. Retrive this by getting
		# last email sent from action mailer.

		user_email = ActionMailer::Base.deliveries.last

		# Parse through to see if it is the correct email.
		expect(user_email).to have_content("You can confirm your account email through the link below")

		# Pull in the New User Info
		user = User.find_by_email('justatest@gmail.com')
		user.should_not be_nil
		user.confirmation_token.should_not be_nil

		ctoken = user_email.body.match(/confirmation_token=\w*/)

		visit "/users/confirmation?#{ctoken}"

		expect(page).to have_content("Your email address has been successfully confirmed")

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
