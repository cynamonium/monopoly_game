class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.text :fields
      t.string :player_1
      t.string :player_2
      t.string :action
      t.integer :turns
      t.string :next_play #player uui
      t.integer :player_1_cash
      t.integer :player_2_cash
      t.string  :jail #player uui
      t.timestamps null: false
    end
  end
end
