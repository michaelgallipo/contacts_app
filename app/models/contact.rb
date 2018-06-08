class Contact < ApplicationRecord

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
