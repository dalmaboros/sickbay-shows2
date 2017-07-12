# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app [Sinatra gem is installed, and controllers use Sinatra routes]
- [x] Use ActiveRecord for storing information in a database [ActiveRecord gem is installed, and used to map the Ruby objects of this project to tables in the database]
- [x] Include more than one model class (list of model class names e.g. User, Post, Category) [This project includes four model classes: Artist, Show, Venue, and User, as well as a join table class ShowArtist]
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts) [The Artist, Show, and Venue classes all have has_many relationships]
- [x] Include user accounts [There is a User class that allows for account creation]
- [ ] Ensure that users can't modify content created by other users [This project's domain was designed to have only a few users who can edit all site content]
- [x] Include user input validations [User input is validated in form HTML elements as well as associated controller routes]
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new) [Validation failures and successes appear as flash messages for all Show, Artist, and Venue forms]
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
