# -*- encoding : utf-8 -*-
class CreateEjecuciones < ActiveRecord::Migration
  def change
    create_table :ejecuciones do |t|
      t.text :entrada
      t.text :resultado_parcial
      t.string :estado_actual
      t.integer :numero_de_paso, :default => 0
      t.integer :posicion_actual, :default => 0

      t.boolean :ejecutada_al_menos_una_vez, :default => false
      t.text :resultado_final
      t.string :estado_final
      t.integer :posicion_final
      t.integer :numero_de_pasos_final
      t.boolean :termina_en_estado_de_aceptacion

      t.boolean :termino, :default => false

      t.references :maquina
      t.timestamps
    end
    add_index :ejecuciones, :maquina_id
  end
end
