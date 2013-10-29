class DefaultLayoutController < ApplicationController
  def prevent_pjax
    prevent_pjax!
  end
end
