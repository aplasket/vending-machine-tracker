# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

owner = Owner.create(name: "Sam's Snacks")

dons = owner.machines.create!(location: "Don's Mixed Drinks")
burger = dons.snacks.create!(name: "White Castle Burger", price: 3.50)
pop_rocks = dons.snacks.create!(name: "Pop Rocks", price: 1.50)

freddies = owner.machines.create!(location: "Freddies Mixed Snacks")
apple = freddies.snacks.create!(name: "Apple", price: 1.00)

turing = owner.machines.create!(location: "Turing Basement")

cheetos = Snack.create!(name: "Flaming Hot Cheetos", price: 2.50)
gushers = Snack.create!(name: "Gushers", price: 2.00)
fruit_rollups = Snack.create!(name: "Fruit Rollups", price: 3.25)

ms1 = MachineSnack.create!(snack_id: cheetos.id, machine_id: dons.id)
ms2 = MachineSnack.create!(snack_id: cheetos.id, machine_id: turing.id)
ms3 = MachineSnack.create!(snack_id: gushers.id, machine_id: turing.id)