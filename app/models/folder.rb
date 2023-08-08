class Folder < ApplicationRecord
  belongs_to :user
  has_many :documents, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :user_id }
end
