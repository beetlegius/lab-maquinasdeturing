# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  include Xexcepciones
  rescue_from ActiveRecord::RecordInvalid, :with => :record_invalid
  rescue_from ActionController::RoutingError, :with => :routing_error
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  protect_from_forgery

  def bloquear_si_terminada(maquina)
    redirect_to root_path, notice: "La máquina de Turing está terminada!" if maquina.terminada?
  end

  private

  def convertir(obj)
    if obj.class == String
      obj.split(",")
    elsif obj.class == Array
      obj.join(",")
    else
      return obj
    end
  end

  def current_user; nil; end

end
