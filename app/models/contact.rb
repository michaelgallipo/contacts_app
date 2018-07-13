class Contact < ApplicationRecord

  belongs_to :user

  has_many :contact_groups
  has_many :groups, through: :contact_groups

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  def friendly_updated_at
    updated_at.strftime("%e %b %Y")
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def japan_phone
    japan_phone = "+81" + cell_phone
  end

end
