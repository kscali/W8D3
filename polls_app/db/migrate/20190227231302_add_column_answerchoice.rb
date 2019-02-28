class AddColumnAnswerchoice < ActiveRecord::Migration[5.2]
  def change
    add_column :answerchoices, :question_id, :integer
  end
end
