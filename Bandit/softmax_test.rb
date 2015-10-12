# softmax_test.rb

require 'gnuplot'
require './bandit'
require './softmax'

# t = 1
average_reward = Array.new(1000, 0)
optimal_action = Array.new(1000, 0)

0.upto 1999 do |m|
  bandit = Bandit.new
  softmax = SoftMax.new(tau: 0.1)
  
  0.upto 999 do |n|
    result = softmax.play_bandit(bandit)
    
    average_reward[n] = (average_reward[n] * m + result[0]) / (m + 1)
    if result[1]
      optimal_action[n] = (optimal_action[n] * m + 100.0) / (m + 1)
    else
      optimal_action[n] = (optimal_action[n] * m + 0.0) / (m + 1)
    end
  end
end

# t = 0.1
average_reward_1 = Array.new(1000, 0)
optimal_action_1 = Array.new(1000, 0)

0.upto 1999 do |m|
  bandit = Bandit.new
  softmax = SoftMax.new(tau: 0.1)
  
  0.upto 999 do |n|
    result = softmax.play_bandit(bandit)
    
    average_reward_1[n] = (average_reward_1[n] * m + result[0]) / (m + 1)
    if result[1]
      optimal_action_1[n] = (optimal_action_1[n] * m + 100.0) / (m + 1)
    else
      optimal_action_1[n] = (optimal_action_1[n] * m + 0.0) / (m + 1)
    end
  end
end

# t = 0.01
average_reward_01 = Array.new(1000, 0)
optimal_action_01 = Array.new(1000, 0)

0.upto 1999 do |m|
  bandit = Bandit.new
  softmax = SoftMax.new(tau: 0.01)
  
  0.upto 999 do |n|
    result = softmax.play_bandit(bandit)
    
    average_reward_01[n] = (average_reward_01[n] * m + result[0]) / (m + 1)
    if result[1]
      optimal_action_01[n] = (optimal_action_01[n] * m + 100.0) / (m + 1)
    else
      optimal_action_01[n] = (optimal_action_01[n] * m + 0.0) / (m + 1)
    end
  end
end

Gnuplot.open do |gp|
  Gnuplot::Plot.new(gp) do |plot|
    plot.yrange "[0.0:1.5]"
    plot.title  'Average Performance (Reward)'
    plot.xlabel 'Steps'
    plot.ylabel 'Average reward'
    plot.set "size ratio 1"
    plot.set "key right bottom"
    plot.terminal("png")
    plot.output("softmax_reward.png")
    x = (0..1000).collect{|v| v.to_f}
    y1 = average_reward.unshift(0)
    y2 = average_reward_1.unshift(0)
    y3 = average_reward_01.unshift(0)

    plot.data << Gnuplot::DataSet.new([x, y1]) do |ds|
      ds.with = "lines ls 1"
      ds.linecolor = 'rgb "blue"'
      ds.linewidth = 2
      ds.title = "τ = 1"
    end
    
    plot.data << Gnuplot::DataSet.new([x, y2]) do |ds|
      ds.with = "lines ls 1"
      ds.linecolor = 'rgb "green"'
      ds.linewidth = 2
      ds.title = "τ = 0.1"
    end
    
    plot.data << Gnuplot::DataSet.new([x, y3]) do |ds|
      ds.with = "lines ls 1"
      ds.linecolor = 'rgb "red"'
      ds.linewidth = 2
      ds.title = "τ = 0.01"
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
    plot.output("softmax_optimal.png")
    x = (0..1000).collect{|v| v.to_f}
    y1 = optimal_action.unshift(0)
    y2 = optimal_action_1.unshift(0)
    y3 = optimal_action_01.unshift(0)

    plot.data << Gnuplot::DataSet.new([x, y1]) do |ds|
      ds.with = "lines ls 1"
      ds.linecolor = 'rgb "blue"'
      ds.linewidth = 2
      ds.title = "τ = 1"
    end
    
    plot.data << Gnuplot::DataSet.new([x, y2]) do |ds|
      ds.with = "lines ls 1"
      ds.linecolor = 'rgb "green"'
      ds.linewidth = 2
      ds.title = "τ = 0.1"
    end
    
    plot.data << Gnuplot::DataSet.new([x, y3]) do |ds|
      ds.with = "lines ls 1"
      ds.linecolor = 'rgb "red"'
      ds.linewidth = 2
      ds.title = "τ = 0.01"
    end
  end
end

