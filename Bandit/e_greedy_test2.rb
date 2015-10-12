# e_greedy_test.rb

require 'gnuplot'
require './bandit'
require './e_greedy'

# e = 0.01
optimal_action_01 = Array.new(10000, 0)

0.upto 1999 do |m|
  bandit = Bandit.new
  greedy = EGreedy.new(epsilon: 0.01)
  
  0.upto 9999 do |n|
    result = greedy.play_bandit(bandit)
    
    if result[1]
      optimal_action_01[n] = (optimal_action_01[n] * m + 100.0) / (m + 1)
    else
      optimal_action_01[n] = (optimal_action_01[n] * m + 0.0) / (m + 1)
    end
  end
end

Gnuplot.open do |gp|
  Gnuplot::Plot.new(gp) do |plot|
    plot.yrange "[0.0:100.0]"
    plot.title  'Average Performance (Optimal Action)'
    plot.xlabel 'Steps'
    plot.ylabel 'Optimal action (%)'
    plot.set "size ratio 1"
    plot.set "key right bottom"
    plot.terminal("png")
    plot.output("e_greedy_optimal2.png")
    x = (0..10000).collect{|v| v.to_f}
    y = optimal_action_01.unshift(0)

    plot.data << Gnuplot::DataSet.new([x, y]) do |ds|
      ds.with = "lines ls 1"
      ds.linecolor = 'rgb "red"'
      ds.linewidth = 2
      ds.title = "ε = 0.01"
    end
  end
end

