namespace :db do
  desc "Ingresar ejecuciones a la Base de Datos"
  task :ingresar_ejecuciones => :environment do
    require "populator"
    require "faker"
    Ejecucion.delete_all()
    Ejecucion.populate 50 do |ejecucion|
        ejecucion.maquina_id = ''
        ejecucion.entrada = ''
        ejecucion.resultado = ''
        ejecucion.estado_actual = ''
        ejecucion.posicion_actual = ''
        ejecucion.estado_final = ''
        ejecucion.termino = ''
          # Faker::Name.first_name
      # Faker::Name.last_name
      # Faker::Internet.free_email(ejecucion.atributo)
      # 0..999
    end
  end
end