class Venue < ActiveRecord::Base
  has_many :shows

  has_many :venue_artists
  has_many :artists, through: :venue_artists

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
