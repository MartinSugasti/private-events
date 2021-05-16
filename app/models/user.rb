class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  validates :username, presence: true, length: { in: 3..50 }, uniqueness: true,
                       format: { with: /\A[a-zA-Z0-9]+\Z/ }

  has_many :created_events, foreign_key: 'creator_id', class_name: 'Event',
                            inverse_of: 'creator', dependent: :destroy

  has_many :invitations, dependent: :destroy, foreign_key: :guest
  has_many :guest_events, through: :invitations, source: :event
end
