# bandit.rb

require 'random_bell'

class Bandit
  @@bell = RandomBell.new(mu: 0.0, sigma: 1.0, range: -10..10)

  # @arms: 10個の（平均の異なる）RandomBellインスタンスを格納する配列
  # @best_arm: @armsの中で最も期待値の大きなRandomBellインスタンスのインデックス
  def initialize(size = 10)
    @arms = []
    size.times{ @arms << @@bell.rand }
    @best_arm = @arms.index(@arms.max)
    @arms.map!{ |m| RandomBell.new(mu: m, sigma: 1.0, range: -10..10) }
  end

  # 結果と最適か否かの情報を配列で返す
  def play(arm)
    result = @arms[arm].rand
    if arm == @best_arm
      best = true
    else
      best = false
    end
    return [result, best]
  end
end

