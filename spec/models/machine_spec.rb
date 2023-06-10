require "rails_helper"

RSpec.describe Machine, type: :model do
  describe "validations" do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks)}
  end

  describe "instance methods" do
    let!(:owner) { Owner.create(name: "Sam's Snacks") }
    let!(:dons)  { owner.machines.create!(location: "Don's Mixed Drinks") }
    let!(:freddies) { owner.machines.create!(location: "Freddies Mixed Snacks") }

    let!(:burger) { dons.snacks.create!(name: "White Castle Burger", price: 3.50) }
    let!(:pop_rocks) { dons.snacks.create!(name: "Pop Rocks", price: 1.50) }
    let!(:cheetos) { dons.snacks.create!(name: "Flaming Hot Cheetos", price: 2.50) }

    let!(:apple) { freddies.snacks.create!(name: "Apple", price: 1.00) }

    describe "#average_snack_price" do
      it "calculates average price of all snacks in machine" do
        expect(dons.average_snack_price).to eq(2.50)
        expect(freddies.average_snack_price).to eq(1.00)
      end
    end
  end
end
