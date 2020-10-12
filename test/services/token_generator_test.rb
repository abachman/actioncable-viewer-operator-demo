require 'test_helper'
require 'descriptive_statistics/safe'

class TokenGeneratorTest < ActiveSupport::TestCase
  def mean(values)
    puts 'NIL!?' if values.nil?
    DescriptiveStatistics.mean(values)
  end

  def percentile(percentile, values)
    puts 'NIL!?' if values.nil?
    DescriptiveStatistics.percentile(percentile, values)
  end

  def stddev(values)
    puts 'NIL!?' if values.nil?
    DescriptiveStatistics.standard_deviation(values)
  end

  def vari(values)
    puts 'NIL!?' if values.nil?
    DescriptiveStatistics.variance(values)
  end

  test 'only alphanumeric' do
    token = TokenGenerator.generate
    assert_match(/\A[a-z0-9]+\z/, token)
  end

  test 'six characters' do
    token = TokenGenerator.generate
    assert_equal(6, token.size)
  end

  test 'uniform randomness of codes' do
    puts 'START'
    character_counts = [{}, {}, {}, {}, {}, {}]
    codes =
      10_000.times.reduce([]) { |acc, n| acc << ::TokenGenerator.generate }

    codes.each do |code|
      6.times do |n|
        character_counts[n][code[n]] =
          character_counts[n][code[n]] ? character_counts[n][code[n]] + 1 : 1
      end
    end

    # character_counts.each_with_index do |cc, n|
    #   vals = cc.values
    #   puts format(
    #          '%i: {keys: %i, avg: %i, 95%%: %i, variance: %i, stddev: %.2f }',
    #          n,
    #          vals.size,
    #          mean(vals),
    #          percentile(95, vals),
    #          vari(vals),
    #          stddev(vals)
    #        )
    # end
  end
end
