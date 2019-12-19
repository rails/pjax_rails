class CapybaraController < ApplicationController
  def prevents_pjax
    prevent_pjax!
  end

  def favicon
    head :not_found
  end
end
