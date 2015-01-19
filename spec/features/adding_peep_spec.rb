require 'spec_helper'

feature "User adds new peep" do
  scenario "when browsing th home page" do
    expect(Peep.count).to eq(0)
    visit '/'
    add_peep("my first peep", "Clint")
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.message).to eq("my first peep")
    expect(peep.owner).to eq("Clint")
  end

  scenario "adding a few tags" do
    visit '/'
    add_peep("my first peep", "Clint", ['London', 'first'])
    peep = Peep.first
    expect(peep.tags.map(&:text)).to include("London")
    expect(peep.tags.map(&:text)).to include("first")
  end

  def add_peep(message, owner, tags = [])
    within('#new-peep') do
      fill_in 'message', :with => message
      fill_in 'owner', :with => owner
      fill_in 'tags', :with => tags.join(' ')
      click_button 'Add peep'
    end
  end
end