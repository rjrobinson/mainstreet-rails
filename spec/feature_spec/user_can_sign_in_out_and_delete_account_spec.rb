require 'rails_helper'

feature 'authenticated user may sign in', %Q(
	As an unauthenticated user
	I want to ...
) do

	scenario 'sign in' do
		user = FactoryGirl.create(:user)

		visit root_path
		click_link 'Sign in'

		fill_in 'Email', with: user.email
		fill_in 'Password', with: user.password
		click_button 'Sign in'

		expect(page).to have_content("Signed in successfully.")
	end

	scenario 'sign out' do
		user = FactoryGirl.create(:user)

		visit root_path
		click_link 'Sign in'

		fill_in 'Email', with: user.email
		fill_in 'Password', with: user.password
		click_button 'Sign in'

		click_link 'Sign out'

		expect(page).to have_content('Signed out successfully')
	end

	scenario 'delete account' do
		user = FactoryGirl.create(:user)

		visit root_path
		click_link 'Sign in'

		fill_in 'Email', with: user.email
		fill_in 'Password', with: user.password
		click_button 'Sign in'

		click_link 'Edit profile'
		# save_and_open_page
		click_button 'Delete my account'

		expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
	end

end
