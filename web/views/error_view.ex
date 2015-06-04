defmodule WorldNote.ErrorView do
  def render("404.html",_) do
    "Page not found"
  end
  def render(_,_) do
    "Server internal error"
  end
end
