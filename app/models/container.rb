class Container < ActiveRecord::Base
  belongs_to :room
  has_many :things
end
