class AddTables < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.string :image
      t.string :video
      t.string :name
      t.string :location
      t.text :story
      t.string :blurb
      t.string :specialty
      t.timestamps null:true
    end

    create_table :products do |t|
      t.references :seller
      t.references :buyer
      t.string :image
      t.string :category
      t.integer :price
      t.timestamps null:true
    end

    create_table :buyers do |t|
      t.string :name
      t.string :password
      t.string :phone
      t.string :email
      t.string :address
      t.timestamps null:true
    end
  end
end
