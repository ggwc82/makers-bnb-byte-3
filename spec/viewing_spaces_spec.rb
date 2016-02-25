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
end
