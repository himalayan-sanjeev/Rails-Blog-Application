class Article < ApplicationRecord
  belongs_to :user
  has_many :comments
  
  has_rich_text :body
  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true
  
  
end
