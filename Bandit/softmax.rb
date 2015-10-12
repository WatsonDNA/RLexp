# softmax.rb

class SoftMax
  include Math
  @@random = Random.new
 
  # @tau: τ の値を保存
  # @values: 行動価値を収める配列
  # @times: 各行動を選択した回数を収める配列
  def initialize(tau: 1.0, size: 10, initial_value: 0.0)
    @tau = tau
    @values = Array.new(10, initial_value)
    @times = Array.new(10, 0)
  end

  # ハンディットを1回プレイする（推定行動価値の更新は漸進的手法で実装）
  def play_bandit(bandit)
    arm = self.softmax_action_select

    result = bandit.play(arm)
    @times[arm] += 1

    @values[arm] = @values[arm] + (result[0] - @values[arm]) / (@times[arm] + 1)

    return result
  end

  #private

  def softmax_action_select
    gibbs = @values.map{ |v| E ** (v / @tau) }
    sum = gibbs.inject(:+)
    rand = @@random.rand

    a, i = 0, 0
    gibbs.each do |g|
      a += g
      break if rand < a / sum
      i += 1
    end

    return i
  end
end
