# -*- encoding : utf-8 -*-
class Ejecucion < ActiveRecord::Base
  belongs_to :maquina

  before_create :inicializar

  serialize :entrada, Array
  serialize :resultado_parcial, Array
  serialize :resultado_final, Array

  POSICION_INICIAL = 0
  EXTREMO_CINTA = [Maquina::SIMBOLO_VACIO]

  # VALIDA QUE LOS ALFABETOS SEAN UN ARREGLO DE SIMBOLOS, Y QUE CADA SIMBOLO TENGA EL FORMATO CORRECTO
  validates_each :entrada do |record, attr, value|
    value.each do |v|
      record.errors.add attr, "#{v} no es un simbolo aceptado por la Maquina de Turing" unless Maquina.find(record.maquina_id).simbolo_es_aceptado?(v)
    end
  end

  def inicializar
    self.entrada = EXTREMO_CINTA if entrada.empty?
    self.resultado_parcial = entrada
    self.estado_actual = maquina.estado_inicial
  end

  def ejecutar!
    funcion = maquina.encontrar_funcion(estado_actual, simbolo_actual)
    self.numero_de_paso += 1
    aplicar_funcion(funcion)
    save!
  end

  def aplicar_funcion(funcion)
    if funcion.nil?
      terminar_ejecucion
    else
      # Cambia el estado y los símbolos
      self.estado_actual = funcion.estado_siguiente
      # self.simbolo_actual = funcion.simbolo_siguiente
      escribir(funcion.simbolo_siguiente)

      # Mueve el cabezal
      avanzar if funcion.movimiento == "derecha"
      retroceder if funcion.movimiento == "izquierda"
      
    end
  end

  def terminar_ejecucion
    self.termino = true
    self.estado_final = estado_actual
    self.resultado_final = resultado_parcial
    self.ejecutada_al_menos_una_vez = true
    self.posicion_final = posicion_actual
    self.numero_de_pasos_final = numero_de_paso
    self.termina_en_estado_de_aceptacion = termino_en_estado_de_aceptacion?
  end

  def reiniciar!
    update_attributes! :posicion_actual => POSICION_INICIAL,
      :estado_actual => POSICION_INICIAL,
      :resultado_parcial => entrada,
      :numero_de_paso => 0,
      :termino => false
  end

  def simbolo_actual
    resultado_parcial[posicion_actual].nil? ? Maquina::SIMBOLO_VACIO : resultado_parcial[posicion_actual]
  end
  alias_method :leer, :simbolo_actual

  def escribir(simbolo)
    self.resultado_parcial[posicion_actual] = simbolo
  end

  def avanzar
    self.posicion_actual += 1
    self.resultado_parcial.concat [Maquina::SIMBOLO_VACIO] if posicion_actual == resultado_parcial.length
  end

  def retroceder
    if posicion_actual == 0
      self.resultado_parcial = ["-"].concat(resultado_parcial)
    else
      self.posicion_actual -= 1
    end
  end

  def termino_en_estado_de_aceptacion?
    maquina.estados_de_aceptacion.include? estado_final
  end

end
