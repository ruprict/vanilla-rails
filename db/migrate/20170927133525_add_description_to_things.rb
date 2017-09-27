class AddDescriptionToThings < ActiveRecord::Migration[5.1]
  def change
    change_table :things do |t|
      t.string :description
    end
  end
end
