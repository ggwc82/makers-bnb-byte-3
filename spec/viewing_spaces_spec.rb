feature 'Viewing spaces' do 

  scenario 'I land in the homepage when I access the website' do
  	visit '/'
  	expect(current_path).to eq('/spaces')
  end

  scenario 'I can return to the homepage from the sign up page' do
  	visit '/'
  	click_button 'Sign up'
  	click_button 'Homepage'
  	expect(current_path).to eq('/spaces')
  end

  scenario 'I can return to the homepage from the sign in page' do
  	visit '/'
  	click_button 'Sign in'
  	click_button 'Homepage'
  	expect(current_path).to eq('/spaces')
  end

  scenario 'I can return to the homepage from the add spaces page' do
  	visit '/spaces/new'
  	click_button 'Homepage'
  	expect(current_path).to eq('/spaces')
  end
end
