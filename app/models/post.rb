class Post < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 50 }
end
