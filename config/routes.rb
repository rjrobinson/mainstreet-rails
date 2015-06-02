Rails.application.routes.draw do
	devise_for :users

	default_url_options :host => "localhost:3000"


	root 'welcome#index'


end
