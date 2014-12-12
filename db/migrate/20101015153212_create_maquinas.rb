# -*- encoding : utf-8 -*-
class CreateMaquinas < ActiveRecord::Migration
  def change
    create_table :maquinas do |t|
      t.string :nombre
      t.string :descripcion
      t.text :estados
      t.text :alfabeto_de_entrada
      t.string :estado_inicial
      t.text :estados_de_aceptacion
      t.boolean :configurada, :default => false # Si esta configurada sólo se pueden agregar funciones
      t.boolean :terminada, :default => false # Si esta terminada no puede modificarse
      t.integer :cantidad_corridas, :default => 0 # Cuenta la cantidad de veces que se corrió la máquina

      t.timestamps
    end
  end
end
