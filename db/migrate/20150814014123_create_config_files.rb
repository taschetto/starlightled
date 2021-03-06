class CreateConfigFiles < ActiveRecord::Migration
  def change
    create_table :config_files do |t|
      t.string :name
      t.string :description
      t.integer :version, limit: 2
      t.jsonb :content, null: false, default: '{}'
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index  :config_files, :content, using: :gin
  end
end
