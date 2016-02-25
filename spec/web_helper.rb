def sign_up(email: 'alice@example.com',
            password: '12345678',
            password_confirmation: '12345678')
  visit '/users/new'
  fill_in :email, with: email
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end


def sign_in(email: 'alice@example.com',
            password: '12345678')
	visit '/sessions/new'
	fill_in :email, with: email
	fill_in :password, with: password
	click_button 'Sign in'
end

def create_space
  visit '/spaces/new'
  fill_in 'name', with: 'Makers Academy'
  fill_in 'location', with: 'San Francisco'
  fill_in 'description', with: 'Office space with beer and pizza'
  fill_in 'price_per_night', with: 888
  fill_in 'available_from', with: 20160224
  fill_in 'available_to', with: 20160315
  click_button 'Create space'
end



