require 'web_helper'
feature 'Adding spaces to user accounts' do

	let(:user) do
		User.create(email: 'user@example.com',
					password: 'secret1234',
					password_confirmation: 'secret1234')
	end

 scenario 'I can add a new space to a user' do
 	visit '/spaces/new'
 	# fill_in 'user_id', with: '1'
 	# fill_in 'email', with: 'alice@example.com'
 	# fill_in 'password', with: 'oranges!'
 	# fill_in 'password_confirmation', with: 'oranges!'

 	click_button 'Create space'
 	space = Space.create(
 		fill_in 'name', with: 'Makers Academy offices'
    fill_in 'location', with: 'San Francisco'
    fill_in 'description', with: 'Office space with beer and pizza'
    fill_in 'price_per_night', with: 888
    fill_in 'available_from', with: 20160224
    fill_in 'available_to', with: 20160315)
 	
 	user = User.first

 	expect(user.space.map(&:name)).to include('Makers Academy Offices')
 end

end

# put in user management spec scenario 'I cannot add a space unless signed in to my account' do