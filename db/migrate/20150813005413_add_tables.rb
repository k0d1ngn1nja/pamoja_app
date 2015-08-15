class AddTables < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.string :video
      t.string :name
      t.string :image
      t.string :location
      t.text :story
      t.string :blurb
      t.string :specialty
      t.timestamps null:true
    end

    create_table :products do |t|
      t.references :seller
      t.string :name
      t.string :description
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

    create_table :images do |t|
      t.references :product
      t.string :file_path
      t.timestamps null:true
    end

    create_table :items do |t|
      t.references :product
      t.references :cart
      t.integer :quantity
      t.timestamps null:true
    end

    create_table :carts do |t|
      t.references :buyer
      t.timestamps null:true
    end
  end
end
