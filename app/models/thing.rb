class Thing < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::KlassMethods

  belongs_to :container
  belongs_to :user
end
