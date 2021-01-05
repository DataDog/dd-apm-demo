def fib(n)
  n <= 1 ? n : fib(n-1) + fib(n-2)
end

loop do
  fib(rand(25..35))
  sleep(0.1)
end
