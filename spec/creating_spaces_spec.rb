feature 'Creating spaces' do

  scenario 'I can create a new space' do
    visit '/spaces/new'
    fill_in 'name', with: 'Makers Academy offices'
    fill_in 'location', with: 'San Francisco'
    click_button 'Create space'

    expect(current_path).to eq '/spaces'

    within 'ul#spaces' do
      expect(page).to have_content('Makers Academy offices')
      expect(page).to have_content('San Francisco')
    end
  end
end