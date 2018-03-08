class Container < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::KlassMethods

  belongs_to :room
  belongs_to :user
  has_many :things
end
