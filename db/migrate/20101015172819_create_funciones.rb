# -*- encoding : utf-8 -*-
class CreateFunciones < ActiveRecord::Migration
  def change
    create_table :funciones do |t|
      t.string :orden
      t.string :estado_actual
      t.string :simbolo_actual
      t.string :estado_siguiente
      t.string :simbolo_siguiente
      t.string :movimiento
      
      t.references :maquina
      t.timestamps
    end
    add_index :funciones, :maquina_id
  end
end
