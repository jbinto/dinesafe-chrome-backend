# For more info on routes: http://guides.rubyonrails.org/routing.html
Dinesafe::Application.routes.draw do
  scope "/app" do
    get "/app_store"  => redirect(Dinesafe.conf.app_store_link)
    get "/" => "pages#app_landing", :as => :app_landing
    get "/privacy"    => "pages#app_privacy"
    get "/about"      => "pages#app_about"
    get "/contact"    => "pages#app_contact"
    get "/press"      => "pages#app_press"
    get "/press_release" => "pages#app_press_release1"
    # URLs look like this: dinesafe.to/app/place/10344670/savoy-pub
    # "place" instead of "establishment" for brevity
    get "/place/:id/:slug"    => "establishments#show_app", :as => :establishment_landing
  end

  # get "/app"            => "pages#app_landing"
  # get "/app/privacy"    => "pages#app_privacy"
  # get "/app/about"      => "pages#app_about"
  # get "/app/contact"      => "pages#app_contact"


  get "inspections/index"
  get "inspections/map"
  get "establishment/search"

  # Routes for API. Versioning it 1.0 to possibly help with future changes.
  scope "/api/1.0" do
    resources :establishments, :inspections, :only => [:index, :show]
  end

  # Redirect homepage to app landing page, for now
  root :to => redirect("/app")
end
