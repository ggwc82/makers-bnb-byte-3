feature 'Viewing spaces' do 

  scenario 'I can see existing spaces on the spaces page' do
    Space.create(name: 'Makers Academy')

    visit '/spaces'
    expect(page.status_code).to eq 200

    within 'ul#space' do
      expect(page).to have_content('Makers Academy')
    end
  end
end
