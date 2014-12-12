# -*- encoding : utf-8 -*-
maquina = Maquina.create :nombre => "Sumador unario",
  :descripcion => "Agrega un 1 a la derecha",
  :estados => ["q0", "q1"],
  :alfabeto_de_entrada => ["1"],
  :estado_inicial => "q0",
  :estados_de_aceptacion => ["q1"]

Funcion.create :maquina => maquina,
  :estado_actual => "q0",
  :simbolo_actual => "1",
  :estado_siguiente => "q0",
  :simbolo_siguiente => "1",
  :movimiento => "derecha"

Funcion.create :maquina => maquina,
  :estado_actual => "q0",
  :simbolo_actual => "-",
  :estado_siguiente => "q1",
  :simbolo_siguiente => "1",
  :movimiento => "derecha"

Ejecucion.create :maquina => maquina,
  :entrada => ["1"]

Ejecucion.create :maquina => maquina,
  :entrada => ["1","1"]

Ejecucion.create :maquina => maquina,
  :entrada => ["1","1","1"]

