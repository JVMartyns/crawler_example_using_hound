defmodule CrawlerExample do
  @moduledoc """
  Navigate to the Elixir Lang page that lists all elixir books
  and get all the book names.
  """
  use Hound.Helpers
  @url "https://elixir-lang.org/learning.html#books"

  @spec run :: list
  def run do
    Hound.start_session()

    navigate_to(@url)

    # Find all elements of type :class named "resource"
    elements = find_all_elements(:class, "resource")

    # Get visible text from elements
    books = Enum.map(elements, &visible_text/1)

    Hound.end_session()

    books
  end
end
