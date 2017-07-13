# Sickbay Shows CMS

## Introduction

Sickbay is an ongoing series of local alternative live music shows in Lafayette, Louisiana and surrounding areas. This project is a web-based content management system for creating and publishing these shows online.

Created as a school project at the Flatiron School, this web app is designed for real world use by the producer of Sickbay for publicly listing events. Visit http://www.sickbay.party to see it in action.

## Installation

1. [Fork and clone](https://help.github.com/articles/cloning-a-repository/) this repository to your machine
2. Install gem dependencies using the following command in your terminal:
```
$ bundle install
```
3. Initialize the database:
```
$ rake db:migrate
```
4. [Install PostgreSQL](https://www.postgresql.org/download/). Open PostgreSQL and start the server (click the start button).
5. Start the application server:
```
$ shotgun
```
6. Navigate to http://localhost:9393 to view the application.

## Usage

Visit http://localhost:9393/backdoor to log in or create a new account
* A logged in user can create, update, and delete shows and news items, as well as individual artists and venues.
* A logged out visitor can see a list of upcoming and archived shows, as well as current news.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dalmaboros/sickbay-shows. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org/version/1/0/0/) code of conduct.

## License

This application is available as open source under the terms of the [MIT License](https://github.com/fastmode/foodme-sinatra-project/blob/master/LICENSE).
