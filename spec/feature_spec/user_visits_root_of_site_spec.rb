require 'rails_helper'

feature 'User visits site', %Q(
	As a User
	I want to visit the root page of the site.
	I should see a Store Hours.

) do

	scenario 'visits the site. ' do

		visit root_path

		expect(page).to have_content "HOURS"
	end

end
