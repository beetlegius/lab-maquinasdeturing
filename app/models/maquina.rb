# -*- encoding : utf-8 -*-
class Maquina < ActiveRecord::Base
  has_many :funciones
  has_many :ejecuciones

  # Los siguientes campos se deben guardar como arreglos, ya que son conjuntos
  serialize :estados, Array
  serialize :estados_de_aceptacion, Array
  serialize :alfabeto_de_entrada, Array

  before_save :actualizar_maquina

  ESTADO_REGEXP = /\w+/
  SIMBOLO_REGEXP = /\w+/
  SIMBOLO_MAQUINA_REGEXP = /[\w|\-]+/
  SIMBOLO_VACIO = '-'

  default_scope order("maquinas.created_at desc")

  # VALIDA QUE NO FALTE NINGÚN CAMPO
  validates :nombre, :estados, :estado_inicial, :estados_de_aceptacion, :alfabeto_de_entrada, :presence => true

  # VALIDA QUE EL ESTADO INICIAL TENGA EL FORMATO CORRECTO
  validates_format_of :estado_inicial, :with => ESTADO_REGEXP

  # VALIDA QUE EL CONJUNTO DE ESTADOS SEA UN ARREGLO DE ESTADOS, Y QUE CADA ESTADO TENGA EL FORMATO CORRECTO
  validates_each :estados, :estados_de_aceptacion do |record, attr, value|
    value.each do |v|
      record.errors.add attr, "#{v} no es un estado válido" unless ESTADO_REGEXP.match(v)
    end
  end

  validates_each :estados_de_aceptacion do |record, attr, value|
    value.each do |v|
      record.errors.add attr, "#{v} no está entre los estados aceptados por la máquina" unless record.estado_es_aceptado?(v)
    end
  end

  # VALIDA QUE LOS ALFABETOS SEAN UN ARREGLO DE SIMBOLOS, Y QUE CADA SIMBOLO TENGA EL FORMATO CORRECTO
  validates_each :alfabeto_de_entrada do |record, attr, value|
    value.each do |v|
      record.errors.add attr, "#{v} no es un símbolo válido" unless SIMBOLO_REGEXP.match(v)
    end
  end

  alias_attribute :to_s, :nombre

  # TODO: revisar
  def actualizar_maquina
    self.estados = estados.compact.uniq
    self.estados_de_aceptacion = estados_de_aceptacion.compact.uniq
    self.alfabeto_de_entrada = alfabeto_de_entrada.compact.uniq
    #    estados.each { |estado| estado.strip! }.uniq!
    #    estados_de_aceptacion.each { |estado| estado.strip! }.uniq!
    #    alfabeto_de_entrada.each { |estado| estado.strip! }.uniq!
  end

  def alfabeto_de_cinta
    alfabeto_de_entrada + [SIMBOLO_VACIO]
  end

  def estado_es_aceptado?(estado)
    estados.include?(estado)
  end

  def simbolo_es_aceptado?(simbolo)
    alfabeto_de_cinta.include?(simbolo)
  end

  def encontrar_funcion(estado_leido, simbolo_leido)
    funciones.detect { |funcion| funcion.es_aplicable?(estado_leido, simbolo_leido) }
  end
  
end
