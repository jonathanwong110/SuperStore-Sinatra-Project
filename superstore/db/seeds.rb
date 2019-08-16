User.create(username:"JW", email: "123@testing.com", password: "12345", location: "NYC")
Item.create(title: "hat", price: 5, description: "new", user_id: 1)
Item.create(title: "t-shirt", price: 10, description: "new", user_id: 1)
Message.create(content: "Can you sell the jacket for cheaper?", user_id: 1)

User.create(username:"OM", email: "123@testing.com", password: "12345", location: "NYC")
Item.create(title: "scarf", price: 10, description: "new", user_id: 2)
Item.create(title: "jacket", price: 40, description: "new", user_id: 2)
Message.create(content: "How does $35 sound?", user_id: 2)
