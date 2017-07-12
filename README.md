## Sickbay Show CMS

### Introduction

Sickbay is an ongoing series of local alternative live music shows in Lafayette, Louisiana and surrounding areas. This project is a web-based content management system for creating and publishing these shows online.

### Installation

1. [Fork and clone](https://help.github.com/articles/cloning-a-repository/) this repository to your machine
2. Install gem dependencies using the following command in your terminal:
```
'bundle install'
```
3. Initialize the database:
```
rake db:migrate
```
4. Start the application server:
```
shotgun
```
5. Navigate to http://localhost:9393 to view the application.

### Usage

1. Run `rake db:migrate` to initialize the database
2. Run `shotgun` to start the application server
3. Visit `localhost:9393` in your browser to view the application
4. Visit `localhost:9393/backdoor` to log in or create a new account

A logged in user can create, update, and delete shows as well as individual artists and venues.

### Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dalmaboros/sickbay-shows. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org/version/1/0/0/) code of conduct.

### License

This application is available as open source under the terms of the [MIT License](https://github.com/fastmode/foodme-sinatra-project/blob/master/LICENSE).
