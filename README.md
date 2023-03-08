# Crawler Example

## Install Chromedriver

chromedriver is required for Hound to communicate with the browser.

- For Fedora 37

```bash
sudo dnf install chromedriver
```

## Configure Hound

Add hound dependence and run `mix deps.get` command:

```elixir
  defp deps do
    [
      ..., # others deps
      {:hound, "~> 1.0"}
    ]
  end
```

On your file `config/config.exs` set:

```elixir
# Setup Hound
config :hound, driver: "chrome_driver", browser: "chrome_headless"
```

On your file `config/test.exs` set `server` option as true:

```elixir
config :crawler_example, CrawlerExampleWeb.Endpoint,
  ..., # others options
  server: true # set as true
```

On your file `test/test_helper.exs` before `ExUnit.start()` set:

```elixir
Application.ensure_all_started(:hound) ## add this
ExUnit.start()
```

### Crawler Example

```elixir
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
```

## Running Crawler Example

Run this command on your console to start chromedriver:

```bash
$ chromedriver

Starting ChromeDriver 110.0.5481.177 (f34f7ab2d4ca4ad498ef42aeba4f4eb2c1392d63-refs/branch-heads/5481@{#1239}) on port 9515
Only local connections are allowed.
Please see https://chromedriver.chromium.org/security-considerations for suggestions on keeping ChromeDriver safe.
ChromeDriver was started successfully.
```

On your iterative IEX run `CrawlerExample.run`:

```elixir
iex(1)> CrawlerExample.run
["Elixir in Action", "Programming Elixir 1.6", "Adopting Elixir",
 "Joy of Elixir", "Learn Functional Programming With Elixir",
 "The Toy Robot Walkthrough", "Elixir Succinctlyfree", "Metaprogramming Elixir",
 "Designing Elixir Systems with OTP", "Concurrent Data Processing in Elixir",
 "Erlang in Angerfree", "Elixir Schoolfree",
 "Pragmatic Studio's Elixir/OTP Course", "grox.io's Elixir Course",
 "grox.io's OTP Course", "ThinkingElixir.com's Pattern Matching Coursefree",
 "LearnElixir.tv", "Educative.io's Metaprogramming in Elixir Course",
 "Learn-Elixir.dev", "ElixirCasts.iofree", "Alchemist Campfree",
 "Elixir Flashcards", "Elixir Koansfree", "Exercism.iofree",
 "Running in Production Podcastfree"]
iex(2)>
```
