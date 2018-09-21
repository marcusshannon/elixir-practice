defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) when is_integer(x) do
    Practice.Calc.factor(x)
  end

  def factor(x) do
    case Integer.parse(x) do
      {n, _} -> Practice.Calc.factor(n)
      :error -> "error"
    end
  end

  def palindrome(string) do
    String.reverse(string) == string
  end

end
