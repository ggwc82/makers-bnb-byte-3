feature 'Viewing spaces' do 

  scenario 'I can see existing spaces on the spaces page' do
    Space.create(name: 'Makers Academy')

    visit '/spaces'
    expect(page.status_code).to eq 200

    within 'ul#spaces' do
      expect(page).to have_content('Makers Academy')
    end
  end

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
end
