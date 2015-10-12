# e_greedy.rb

class EGreedy
  @@random = Random.new
 
  # @epsilon: ε の値を保存
  # @values: 行動価値を収める配列
  # @times: 各行動を選択した回数を収める配列
  def initialize(epsilon: 0.0, size: 10, initial_value: 0.0)
    @epsilon = epsilon
    @values = Array.new(10, initial_value)
    @times = Array.new(10, 0)
  end

  # ハンディットを1回プレイする（推定行動価値の更新は漸進的手法で実装）
  def play_bandit(bandit)
    if @@random.rand < @epsilon
      arm = rand(10)
    else
      arm = @values.index(@values.max)
    end

    result = bandit.play(arm)
    @times[arm] += 1

    @values[arm] = @values[arm] + (result[0] - @values[arm]) / (@times[arm] + 1)

    return result
  end
end
