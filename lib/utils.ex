defmodule Utils do
  def strip_html_tags(html_text) do
    text_without_tags = Regex.replace(~r/<(.|\n)*?>/, html_text, "")
    Regex.replace(~r/&#?[a-z0-9]{2,8};/, text_without_tags, "")
  end
end
