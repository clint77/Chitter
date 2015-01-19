require 'spec_helper'

feature "User browses the list of peeps" do

  before(:each) {
    Peep.create(:owner => "Clint",
                :message => "my first peep",
                :tags => [Tag.first_or_create(:text => 'first')])
    Peep.create(:owner => "April",
                :message => "A basket full of oranges!",
                :tags => [Tag.first_or_create(:text => 'food')])

  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("my first peep")
  end

  scenario "filtered by tags" do
    visit '/tags/first'
    expect(page).not_to have_content("A basket full of oranges!")
    expect(page).not_to have_content("April")
    expect(page).to have_content("my first peep")
    expect(page).to have_content("Clint")
  end
end