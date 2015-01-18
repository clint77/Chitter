require 'spec_helper'

feature "User browses the list of peeps" do

  before(:each) {
    Peep.create(:owner => "Clint",
                :url => "www.peep.com",
                :message => "my first peep")
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("my first peep")
  end
end