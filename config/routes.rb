Maquinasdeturing::Application.routes.draw do
  resources :ejecuciones
  resources :maquinas do
    get :paso_dos, :on => :member
    put :update_paso_dos, :on => :member
    get :terminar, :on => :member
    resources :funciones, :ejecuciones, :shallow => true
  end
  resources :funciones, :only => [:index]
  resources :ejecuciones, :only => [:index] do
    put :ejecutar, :on => :member
    get :reiniciar, :on => :member
  end

  root :to => 'maquinas#index'

end
