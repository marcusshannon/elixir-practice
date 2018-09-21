defmodule Practice.Calc do
  def parse_float(text) do
    case Float.parse(text) do
      {num, _} -> num
      :error -> :error
    end
  end

  def mapfunc(x) do
    case Float.parse(x) do
      {num, _} -> {:num, num}
      :error -> {:op, x}
    end
  end

  def reducefunc({:num, x}, acc) do
    {[x | elem(acc, 0)], elem(acc, 1)}
  end

  def reducefunc({:op, x}, {stack1, []}) do
    {stack1, [x]}
  end

  def reducefunc({:op, a}, {stack1, [b | _] = stack2}) when a in ["*", "/"] and b in ["+", "-"] do
    {stack1, [a | stack2]}
  end

  def reducefunc({:op, a}, {stack1, [b | rest]}) when a in ["+", "-"] and b in ["*", "/"] do
    reducefunc({:op, a}, {[b | stack1], rest})
  end

  def reducefunc({:op, a}, {stack1, [b | rest]}) do
    {[b | stack1], [a | rest]}
  end

  def calculate("+", [b, c | t]) when is_float(b) and is_float(c) do
    [c + b | t]
  end

  def calculate("-", [b, c | t]) when is_float(b) and is_float(c) do
    [c - b | t]
  end

  def calculate("*", [b, c | t]) when is_float(b) and is_float(c) do
    [c * b | t]
  end

  def calculate("/", [b, c | t]) when is_float(b) and is_float(c) do
    [c / b | t]
  end

  def calculate(x, list) do
    [x | list]
  end

  def calc(expr) do
    res =
      expr
      |> String.split(~r/\s+/)
      |> Enum.map(&mapfunc/1)
      |> Enum.reduce({[], []}, &reducefunc/2)

    res2 =
      Enum.reverse(Enum.concat(Enum.reverse(elem(res, 1)), elem(res, 0)))
      |> Enum.reduce([], &calculate/2)
      |> hd

    res2
  end

  def factor(n, p, list) when n < p * p do
    Enum.reverse([n | list])
  end

  def factor(n, p, list) when rem(n, p) == 0 do
    factor(div(n, p), p, [p | list])
  end

  def factor(n, p, list) do
    factor(n, p + 1, list)
  end

  def factor(x) do
    factor(x, 2, [])
  end
end
