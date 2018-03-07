class Container < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::KlassMethods

  belongs_to :room
  has_many :things
end
