class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::KlassMethods

  has_secure_password
  has_many :buildings
  has_many :rooms, through: :buildings
  has_many :containers, through: :rooms
  has_many :things, through: :containers
end
