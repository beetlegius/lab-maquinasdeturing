# -*- encoding : utf-8 -*-
class Funcion < ActiveRecord::Base
  belongs_to :maquina

  Maquina::ESTADO_REGEXP
  Maquina::SIMBOLO_REGEXP
  MOVIMIENTO_REGEXP = /[izquierda|derecha|-]/
  MOVIMIENTOS = :derecha, :izquierda

  validates :estado_actual, :simbolo_actual, :estado_siguiente, :simbolo_siguiente, :movimiento, :presence => true
  validates :estado_actual, :uniqueness => { :scope => [:simbolo_actual, :maquina_id], :message => "La combinación '#{Funcion.human_attribute_name :estado_actual}' y '#{Funcion.human_attribute_name :simbolo_actual}' seleccionada ya existe, no puede repetirse." }

  validates :estado_actual, :estado_siguiente, :format => { :with => Maquina::ESTADO_REGEXP }
  validates :simbolo_actual, :simbolo_siguiente, :format => { :with => Maquina::SIMBOLO_MAQUINA_REGEXP }
  validates :movimiento, :format => { :with => MOVIMIENTO_REGEXP }

  validates_each :estado_actual, :estado_siguiente do |record, attr, value|
    record.errors.add attr, "#{value} no es posible" unless Maquina.find(record.maquina_id).estado_es_aceptado?(value)
  end

  validates_each :simbolo_actual, :simbolo_siguiente do |record, attr, value|
    record.errors.add attr, "#{value} no es posible" unless Maquina.find(record.maquina_id).simbolo_es_aceptado?(value)
  end

  def to_s
    "(#{estado_actual},#{simbolo_actual})=>(#{estado_siguiente}, #{simbolo_siguiente}, #{movimiento})"
  end

  def es_aplicable?(estado,simbolo)
    estado_actual == estado && simbolo_actual == simbolo
  end

end