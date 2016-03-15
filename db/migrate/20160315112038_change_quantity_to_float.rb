class ChangeQuantityToFloat < ActiveRecord::Migration
  def change
  	change_column :quantities, :quantity, :float
  end
end
