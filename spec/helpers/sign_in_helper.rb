def make_user
	user = FactoryGirl.create(:user)
	user.confirm!

	user
end
