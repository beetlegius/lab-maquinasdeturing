namespace :db do
  desc "Ingresar programas a la Base de Datos"
  task :ingresar_programas => :environment do
    require "populator"
    require "faker"
    Programa.delete_all()
    Programa.populate 50 do |programa|
        programa.maquina_id = ''
        programa.entrada = ''
        programa.resultado = ''
        programa.estado_actual = ''
        programa.posicion_actual = ''
        programa.estado_final = ''
        programa.termino = ''
          # Faker::Name.first_name
      # Faker::Name.last_name
      # Faker::Internet.free_email(programa.atributo)
      # 0..999
    end
  end
end