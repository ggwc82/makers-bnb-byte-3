feature 'Creating spaces' do

  scenario 'I can create a new space' do
    visit '/spaces/new'
    fill_in 'name', with: 'Makers Academy offices'
    fill_in 'location', with: 'San Francisco'
    fill_in 'description', with: 'Office space with beer and pizza'
    click_button 'Create space'

    expect(current_path).to eq '/spaces'

    within 'ul#spaces' do
      expect(page).to have_content('Makers Academy offices')
      expect(page).to have_content('San Francisco')
      expect(page).to have_content('Office space with beer and pizza')
    end
  end
end
