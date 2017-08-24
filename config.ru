require './config/environment'
$stdout.sync = true

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use ShowsController
use ArtistsController
use VenuesController
use UsersController
use NewsController
use NewsletterController
run ApplicationController
