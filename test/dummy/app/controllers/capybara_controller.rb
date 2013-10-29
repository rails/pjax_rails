class CapybaraController < ApplicationController
  def prevents_pjax
    prevent_pjax!
  end
end
