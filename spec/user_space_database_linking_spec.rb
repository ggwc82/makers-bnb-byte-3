require 'web_helper'


feature 'Adding spaces to user accounts' do

	scenario 'I can add a new space to a user' do
		sign_up
		create_space
		user = User.first
	 	expect(user.spaces.map(&:name)).to include('Makers Academy')
	end
end

