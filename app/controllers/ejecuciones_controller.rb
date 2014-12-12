# -*- encoding : utf-8 -*-
class EjecucionesController < ApplicationController
  load_resource :maquina
  load_resource :through => :maquina, :shallow => true

  def show
    @maquina = @ejecucion.maquina
    @funciones = @maquina.funciones
  end

  def create
    # @maquina = Maquina.find params[:maquina_id]
    params[:ejecucion][:entrada] = convertir params[:ejecucion][:entrada]
    @ejecucion = @maquina.ejecuciones.build params[:ejecucion]
    @ejecucion.save!
    redirect_to @ejecucion
  end

  def ejecutar
    redirect :back, notice: "No puede ejecutarse, ya ha terminado" and return if @ejecucion.termino?
    @maquina = @ejecucion.maquina
    @ejecucion.ejecutar!

    respond_to do |format|
      format.html
      format.js
    end
  end
    
  def reiniciar
    @ejecucion.reiniciar!
    redirect_to @ejecucion
  end

  private

  def record_invalid
    case action_name.to_sym
    when :create
      @funciones = @maquina.funciones
      @ejecuciones = @maquina.ejecuciones
      render 'maquinas/show'
    else
      super
    end
  end

end
