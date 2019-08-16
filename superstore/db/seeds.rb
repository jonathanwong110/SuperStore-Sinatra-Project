User.create(username:"JW", email: "123@testing.com", password: "12345", location: "NYC")
Item.create(title: "hat", price: 5, description: "new", user_id: 1)
Item.create(title: "t-shirt", price: 10, description: "new", user_id: 1)

User.create(username:"OM", email: "123@testing.com", password: "12345", location: "NYC")
Item.create(title: "scarf", price: 10, description: "new", user_id: 2)
Item.create(title: "jacket", price: 40, description: "new", user_id: 2)
