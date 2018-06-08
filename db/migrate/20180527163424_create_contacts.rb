class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :email
      t.string :cell_phone

      t.timestamps
    end
  end
end
