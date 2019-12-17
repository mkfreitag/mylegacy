class AddVideoToArtifacts < ActiveRecord::Migration[5.2]
  def change
    add_column :artifacts, :video, :string
  end
end
