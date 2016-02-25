require 'web_helper'

# feature 'checking database relationships' do 
# 	describe Space do
# 	  it { should belong_to(:user) }
# 	end

# 	describe User do
# 	  it { should have_many(:space) }
# 	end
# end

feature 'Adding spaces to user accounts' do
		
		# let(:user) do
		# 	sign_up
		# 	sign_in
		# end
		# let(:space) do
		# 	create_space
		# end

	scenario 'I can add a new space to a user' do
		sign_up
		create_space
		user = User.first
		p user.spaces
	 	expect(user.spaces.map(&:name)).to include('Makers Academy')
	end
end


# put in user management spec scenario 'I cannot add a space unless signed in to my account' do