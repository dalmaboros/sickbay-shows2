class Show < ActiveRecord::Base
  belongs_to :venue

  has_many :show_artists
  has_many :artists, through: :show_artists

end
