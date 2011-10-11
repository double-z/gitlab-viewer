Gitlab::Application.routes.draw do
  resources :projects, :only => [:new, :create, :index]

  resources :projects, :except => [:new, :create, :index], :path => "/" do 
    member do 
      get "tree"
      get "blob"
      get "wall"

      # tree viewer
      get "tree/:commit_id" => "projects#tree"
      get "tree/:commit_id/:path" => "projects#tree",
      :as => :tree_file,
      :constraints => { 
        :id => /[a-zA-Z0-9]+/,
        :commit_id => /[a-zA-Z0-9]+/,
        :path => /.*/
      }

    end
    resources :commits
    resources :notes, :only => [:create, :destroy]
  end
  root :to => "projects#index"
end
