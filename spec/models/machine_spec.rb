require "rails_helper"

RSpec.describe Machine, type: :model do
  describe "validations" do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks)}
  end

  describe "instance methods" do
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

    describe "#average_snack_price" do
      it "calculates average price of all snacks in machine" do
        expect(dons.average_snack_price).to eq(2.50)
        expect(freddies.average_snack_price).to eq(1.00)
      end
    end

    describe "#snack_count" do
      it "calculates number of snacks in machine" do
        expect(dons.snack_count).to eq(3)
        expect(turing.snack_count).to eq(2)
        expect(freddies.snack_count).to eq(1)
      end
    end
  end
end
