# Add seed data here. Seed your database with `rake db:seed`

biergarten = Venue.create(name: "The Wurst Biergarten")

# SHOW 1
show1 = Show.create(date: "2017-07-08", venue: biergarten, url: "https://www.facebook.com/events/232534573930858/")

adult_braces = Artist.create(name: "Adult Braces")
now_i = Artist.create(name: "Now I Am Become Death")
marie = Artist.create(name: "Marie")
mystery = Artist.create(name: "Mystery Guest")

show1.artists.push(adult_braces, now_i, marie, mystery)
show1.save

# SHOW 2
show2 = Show.create(date: "2017-07-20", venue: biergarten, url: "https://www.facebook.com/events/1297886260310745/")

tumbling_wheels = Artist.create(name: "Tumbling Wheels")
the_reeds = Artist.create(name: "Mitch & Renée Reed")

show2.artists.push(tumbling_wheels, the_reeds)
show2.save

# NEWS ITEM 1

news1 = News.create(date: "2017-07-12", content: "New Sickbay Singles Club release by Sarcotics coming August 4th!", url: "https://sickbaysounds.bandcamp.com/")
