defmodule My do

  defmacro if( condition, clauses ) do
    do_clause = Keyword.get( clauses, :do, nil )
    else_clause = Keyword.get( clauses, :else, nil )
    quote do
      case unquote( condition ) do
        val when val in [ false, nil ] -> unquote( else_clause )
        _ -> unquote( do_clause )
      end
    end
  end

  defmacro unless( condition, clauses ) do
    do_clause = Keyword.get( clauses, :do, nil )
    else_clause = Keyword.get( clauses, :else, nil )
    quote do
      case unquote( condition ) do
        val when val in [ false, nil ] -> unquote( do_clause )
        _ -> unquote( else_clause )
      end
    end
  end

  defmacro times_n( n ) do
    quote do
      def unquote(:"times_#{n}")(k) do
        unquote(n) * k
      end
    end
  end

end

defmodule Test do

  require My

  My.if 1 == 2 do
    IO.puts "1 == 2"
  else
    IO.puts "1 != 2"
  end

  My.unless 1 == 2 do
    IO.puts "1 != 2"
  else
    IO.puts "1 == 2"
  end

  My.times_n(3)

end

IO.puts Test.times_3(5)
