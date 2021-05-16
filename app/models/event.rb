class Event < ApplicationRecord
  validates :title, presence: true, length: { in: 3..30 }, allow_blank: false
  validates :location, presence: true, length: { in: 3..50 }, allow_blank: false
  validates :description, presence: true, length: { in: 3..200 }, allow_blank: false
  validates :start_at, presence: true

  belongs_to :creator, class_name: 'User'

  has_many :invitations, dependent: :destroy
  has_many :guests, through: :invitations

  scope :upcoming, -> { where('start_at > ?', Time.zone.now) }
  scope :past, -> { where('start_at <= ?', Time.zone.now) }
end
