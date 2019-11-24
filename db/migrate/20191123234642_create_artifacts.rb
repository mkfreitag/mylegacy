class CreateArtifacts < ActiveRecord::Migration[5.2]
  def change
    create_table :artifacts do |t|
      t.text :comment
      t.integer :user_id
      t.integer :event_id
      t.timestamps
    end
    add_index :artifacts, :user_id
    add_index :artifacts, :event_id
  end
end
