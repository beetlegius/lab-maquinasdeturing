namespace :db do
  desc "Ingresar funciones a la Base de Datos"
  task :ingresar_funciones => :environment do
    require "populator"
    require "faker"
    Funcion.delete_all()
    Funcion.populate 50 do |funcion|
        funcion.estado_actual = ''
        funcion.simbolo_actual = ''
        funcion.estado_siguiente = ''
        funcion.simbolo_siguiente = ''
        funcion.movimiento = ''
          # Faker::Name.first_name
      # Faker::Name.last_name
      # Faker::Internet.free_email(funcion.atributo)
      # 0..999
    end
  end
end