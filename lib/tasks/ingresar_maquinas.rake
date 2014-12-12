namespace :db do
  desc "Ingresar maquinas a la Base de Datos"
  task :ingresar_maquinas => :environment do
    require "populator"
    require "faker"
    Maquina.delete_all()
    Maquina.populate 50 do |maquina|
        maquina.estados = ''
        maquina.alfabeto_de_entrada = ''
        maquina.alfabeto_de_cinta = ''
        maquina.estado_inicial = ''
        maquina.estados_de_aceptacion = ''
          # Faker::Name.first_name
      # Faker::Name.last_name
      # Faker::Internet.free_email(maquina.atributo)
      # 0..999
    end
  end
end