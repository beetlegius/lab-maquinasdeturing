# -*- encoding : utf-8 -*-
class MaquinasController < ApplicationController
  load_resource

  def index
  end

  def show
    @funciones = @maquina.funciones
    @ejecuciones = @maquina.ejecuciones
    @ejecucion = Ejecucion.new
  end

  def new
  end

  def create
    maq = params[:maquina]
    maq[:estados] = convertir maq[:estados]
    maq[:alfabeto_de_entrada] = convertir maq[:alfabeto_de_entrada]
    maq[:estado_inicial] = maq[:estados].first
    maq[:estados_de_aceptacion] = [maq[:estados].last]

    @maquina = Maquina.new maq
    @maquina.save!
    redirect_to paso_dos_maquina_path(@maquina), notice: "La máquina fue agregada! Ahora debes configurarla."
  end

  def edit
    bloquear_si_terminada @maquina
  end

  def update
    bloquear_si_terminada @maquina
    @maquina.update_attributes! params[:maquina]
    redirect_to maquinas_path, notice: "La máquina fue modificada!"
  end

  def destroy
    @maquina.destroy
    redirect_to maquinas_path
  end

  def terminar
    @maquina.update_attributes! :terminada => true
    redirect_to maquinas_path, notice: "La máquina ha sido terminada."
  end

  def paso_dos
    bloquear_si_terminada @maquina
    @maquina.estados_de_aceptacion = @maquina.estados_de_aceptacion.join(",") if @maquina.estados_de_aceptacion?
  end

  def update_paso_dos
    bloquear_si_terminada @maquina
    maq = params[:maquina]
    maq[:estados_de_aceptacion] = convertir maq[:estados_de_aceptacion]
    @maquina.update_attributes! maq
    redirect_to maquina_funciones_path(@maquina), notice: "La máquina ha sido configurada. Ya puedes agregarle funciones."
  end

  private

  def record_invalid
    case action_name.to_sym
    when :create
      @maquina.estados = convertir @maquina.estados if @maquina.estados?
      @maquina.alfabeto_de_entrada = convertir @maquina.alfabeto_de_entrada if @maquina.alfabeto_de_entrada?
      super
    when :update_paso_dos
      @maquina.estados_de_aceptacion = convertir @maquina.estados_de_aceptacion if @maquina.estados_de_aceptacion?
      render :paso_dos
    else
      super
    end
  end

end
