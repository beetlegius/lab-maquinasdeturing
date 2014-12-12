namespace :db do
  desc "Ingresar corridas a la Base de Datos"
  task :ingresar_corridas => :environment do
    require "populator"
    require "faker"
    Corrida.delete_all()
    Corrida.populate 50 do |corrida|
        corrida.maquina_id = ''
        corrida.entrada = ''
        corrida.resultado = ''
        corrida.estado_actual = ''
        corrida.posicion_actual = ''
        corrida.estado_final = ''
        corrida.termino = ''
          # Faker::Name.first_name
      # Faker::Name.last_name
      # Faker::Internet.free_email(corrida.atributo)
      # 0..999
    end
  end
end