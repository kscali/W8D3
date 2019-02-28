class CreateAnswerchoices < ActiveRecord::Migration[5.2]
  def change
    create_table :answerchoices do |t|
      t.string :text
      t.timestamps
    end
  end
end
