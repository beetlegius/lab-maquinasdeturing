# -*- encoding : utf-8 -*-
# Manejo de excepciones
module Xexcepciones

  # ActiveRecord::RecordNotFound
  # Se llama cuando se intenta acceder a un objeto que no existe.
  # aplicacion:3000/productos/sarasasasa
  def record_not_found
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
  end

  # ActionController::RoutingError
  # Se llama cuando se intenta acceder a un controlador, o una ruta que no existe.
  # aplicacion:3000/lasanputa
  def routing_error
    redirect_to root_url
  end

  # ActiveRecord::RecordInvalid
  # Se llama cuando no se pudo guardar un objeto tanto al crearlo como al editarlo.
  # Ejemplo: campo obligatorio vacío.
  def record_invalid
    case action_name.to_sym
    when :create
      render :new
    when :update
      render :edit
    else
      record_not_found
    end
  end

end
