# -*- encoding : utf-8 -*-
class FuncionesController < ApplicationController
  load_resource :maquina
  load_resource :through => :maquina, :shallow => true

  def index
    bloquear_si_terminada @maquina
    @funcion = Funcion.new
  end

  def edit
    @maquina = @funcion.maquina
    bloquear_si_terminada @maquina
  end

  def create
    bloquear_si_terminada @maquina
    @funcion = @maquina.funciones.build params[:funcion]
    @funcion.save!
    redirect_to maquina_funciones_path(@maquina), notice: "La función fue agregada! Ya puedes ejecutarla."
  end

  def update
    bloquear_si_terminada @funcion.maquina
    @funcion.update_attributes! params[:funcion]
    redirect_to maquina_funciones_path(@funcion.maquina), notice: "La función fue modificada!"
  end

  def destroy
    bloquear_si_terminada @funcion.maquina
    @funcion.destroy
    redirect_to maquina_funciones_path(@funcion.maquina), notice: "La función fue eliminada!"
  end

  private

  def record_invalid
    case action_name.to_sym
    when :create
      @funciones = @maquina.funciones.delete_if { |f| f.new_record? }
      render :index
    when :update
      @maquina = @funcion.maquina
      super
    else
      super
    end
  end

end
