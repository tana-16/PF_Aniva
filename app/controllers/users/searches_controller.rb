class Users::SearchesController < ApplicationController
  def search
    @content=params["search"]["value"]
    @records=User.search_for(@content)
  end
end
