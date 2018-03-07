require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
run ApplicationController
use BuildingsController
use ContainersController
use RoomsController
use ThingsController
use UsersController
