# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101015220752) do

  create_table "ejecuciones", :force => true do |t|
    t.text     "entrada"
    t.text     "resultado_parcial"
    t.string   "estado_actual"
    t.integer  "numero_de_paso",                  :default => 0
    t.integer  "posicion_actual",                 :default => 0
    t.boolean  "ejecutada_al_menos_una_vez",      :default => false
    t.text     "resultado_final"
    t.string   "estado_final"
    t.integer  "posicion_final"
    t.integer  "numero_de_pasos_final"
    t.boolean  "termina_en_estado_de_aceptacion"
    t.boolean  "termino",                         :default => false
    t.integer  "maquina_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ejecuciones", ["maquina_id"], :name => "index_ejecuciones_on_maquina_id"

  create_table "funciones", :force => true do |t|
    t.string   "orden"
    t.string   "estado_actual"
    t.string   "simbolo_actual"
    t.string   "estado_siguiente"
    t.string   "simbolo_siguiente"
    t.string   "movimiento"
    t.integer  "maquina_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "funciones", ["maquina_id"], :name => "index_funciones_on_maquina_id"

  create_table "maquinas", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.text     "estados"
    t.text     "alfabeto_de_entrada"
    t.string   "estado_inicial"
    t.text     "estados_de_aceptacion"
    t.boolean  "configurada",           :default => false
    t.boolean  "terminada",             :default => false
    t.integer  "cantidad_corridas",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
