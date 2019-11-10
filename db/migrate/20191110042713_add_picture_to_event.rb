class AddPictureToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event, :string
  end
end
