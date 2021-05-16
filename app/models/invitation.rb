class Invitation < ActiveRecord::Base
  belongs_to :guest, class_name: 'User'
  belongs_to :event

  enum status: [:no_answer, :accepted, :declined]
end
