class CreateParams < ActiveRecord::Migration
  def change
    create_table :params do |t|
      t.text :description
      t.string :name           , unique: true , null: false
      t.integer :code          , unique: true , null: false       , limit: 2
      t.references :company    , index: true  , foreign_key: true , null: false
      t.references :event_code , index: true  , foreign_key: true , null: false

      t.timestamps null: false
    end
  end
end
