namespace :db do
  desc "Ingresar recorridos a la Base de Datos"
  task :ingresar_recorridos => :environment do
    require "populator"
    require "faker"
    Recorrido.delete_all()
    Recorrido.populate 50 do |recorrido|
        recorrido.maquina_id = ''
        recorrido.entrada = ''
        recorrido.resultado = ''
        recorrido.estado_actual = ''
        recorrido.posicion_actual = ''
        recorrido.estado_final = ''
        recorrido.termino = ''
          # Faker::Name.first_name
      # Faker::Name.last_name
      # Faker::Internet.free_email(recorrido.atributo)
      # 0..999
    end
  end
end