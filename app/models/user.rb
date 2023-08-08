class User < ApplicationRecord
  ROLES = %w[teacher student admin].freeze

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
