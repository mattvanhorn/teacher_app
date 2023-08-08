class User < ApplicationRecord
  ROLES = %w[teacher student admin].freeze

  has_many :folders, dependent: :destroy
  has_many :documents, through: :folders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES.each do |role|
    class_eval do
      scope role.pluralize.to_sym, -> { where(role: role) }
      define_method("#{role}?") { self.role == role }
    end
  end

end
