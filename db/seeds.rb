# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "admin@example.com",
	name: "admin",
	password: "password",
	password_confirmation: "password",
	admin: true)
Project.find_or_create_by(name: "Ticketee Beta")

State.find_or_create_by(name: 'New', background: "#85FF00", color: 'white')
State.find_or_create_by(name: 'Open', background: "#00CFFD", color: 'white')
State.find_or_create_by(name: 'Closed', background: "black", color: 'white')
