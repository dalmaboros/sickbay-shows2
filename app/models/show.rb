class Show < ActiveRecord::Base
  validates :date, presence: true

  belongs_to :venue
  has_many :show_artists
  has_many :artists, through: :show_artists

  validates_associated :artists
  validates_associated :venue

end
