feature 'Creating spaces' do

  scenario 'I can create a new space' do
    visit '/spaces/new'
    fill_in 'name', with: 'Makers Academy offices' 
    fill_in 'location', with: 'San Francisco'  
    fill_in 'description', with: 'Office space with beer and pizza' 
    fill_in 'price_per_night', with: 888 
    fill_in 'available_from', with: 20160224 
    fill_in 'available_to', with: 20160315 
    click_button 'Create space'

    expect(current_path).to eq '/spaces'

    within 'ul#spaces' do
      expect(page).to have_content('Makers Academy offices')
      expect(page).to have_content('San Francisco')
      expect(page).to have_content('Office space with beer and pizza')
      expect(page).to have_content(888)
      expect(page).to have_content('2016-02-24')
      expect(page).to have_content('2016-03-15')
    end
  end

 


end
