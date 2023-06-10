require "rails_helper"

RSpec.describe "/snacks/:id, snack show page", type: :feature do
  describe "As a visitor on the snack show page" do
    let!(:cheetos) { Snack.create!(name: "Flaming Hot Cheetos", price: 2.50) }
    let!(:gushers) { Snack.create!(name: "Gushers", price: 2.00) }
    let!(:fruit_rollups) { Snack.create!(name: "Fruit Rollups", price: 3.25) }

    let!(:owner) { Owner.create(name: "Sam's Snacks") }

    let!(:dons)  { owner.machines.create!(location: "Don's Mixed Drinks") }
    let!(:burger) { dons.snacks.create!(name: "White Castle Burger", price: 3.50) }
    let!(:pop_rocks) { dons.snacks.create!(name: "Pop Rocks", price: 1.50) }
    let!(:ms1) { MachineSnack.create!(snack_id: cheetos.id, machine_id: dons.id) }

    let!(:freddies) { owner.machines.create!(location: "Freddies Mixed Snacks") }
    let!(:apple) { freddies.snacks.create!(name: "Apple", price: 1.00) }

    let!(:turing) { owner.machines.create!(location: "Turing Basement") }
    let!(:ms2) { MachineSnack.create!(snack_id: cheetos.id, machine_id: turing.id) }
    let!(:ms3) { MachineSnack.create!(snack_id: gushers.id, machine_id: turing.id) }

    #userstory 3
    it "displays the name, price and locations of the snack, snack count + average snack price for that location" do
      visit snack_path(cheetos)

      expect(page).to have_content(cheetos.name)
      expect(page).to have_content("Price: $#{cheetos.price}")
      expect(page).to have_content("Locations:")
      expect(page).to have_content("#{dons.location} (#{dons.snack_count} kinds of snacks, average price of $#{dons.average_snack_price})")
      expect(page).to have_content("#{turing.location} (#{turing.snack_count} kinds of snacks, average price of $#{turing.average_snack_price})")
      expect(page).to_not have_content(freddies.location)
      expect(page).to_not have_content(burger.name)
      expect(page).to_not have_content(pop_rocks.name)
    end
  end
end