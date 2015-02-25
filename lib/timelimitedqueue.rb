# タイムアウトを使われるとテストが困難になるので、
# こちらのペースで消化できるように挙動を変える。

miquire :lib, 'timelimitedqueue'
class TimeLimitedQueue
  def pushed_event; end

  def process_all
    while !empty?
      @stock << pop
      callback
    end
  end
end
