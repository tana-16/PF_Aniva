class Users::SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @content=params["search"]["value"]
    @records=User.search_for(@content)
  end
end
