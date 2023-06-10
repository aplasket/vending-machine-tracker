require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end
  describe "userstory 1" do
    let!(:owner) { Owner.create(name: "Sam's Snacks") }
    let!(:dons)  { owner.machines.create!(location: "Don's Mixed Drinks") }
    let!(:freddies) { owner.machines.create!(location: "Freddies Mixed Snacks") }

    let!(:burger) { dons.snacks.create!(name: "White Castle Burger", price: 3.50) }
    let!(:pop_rocks) { dons.snacks.create!(name: "Pop Rocks", price: 1.50) }
    let!(:cheetos) { dons.snacks.create!(name: "Flaming Hot Cheetos", price: 2.50) }

    let!(:apple) { freddies.snacks.create!(name: "Apple", price: 1.00) }

    it "displays all snacks and their associated price" do
      visit machine_path(dons)

      expect(page).to have_content("#{dons.location} Vending Machine")
      expect(page).to have_content("Snacks:")

      within "#snack-#{burger.id}" do
        expect(page).to have_content(burger.name)
        expect(page).to have_content(burger.price)
      end

      within "#snack-#{pop_rocks.id}" do
        expect(page).to have_content(pop_rocks.name)
        expect(page).to have_content(pop_rocks.price)
      end

      within "#snack-#{cheetos.id}" do
        expect(page).to have_content(cheetos.name)
        expect(page).to have_content(cheetos.price)
      end

      expect(page).to_not have_content(apple.name)
      expect(page).to_not have_content("#{freddies.location} Vending Machine")
    end

    it "shows the average price for all of the snacks in that machine" do
      visit machine_path(dons)
      
      expect(page).to have_content("Average Price: $2.5")
    end
  end
end
