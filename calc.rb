require 'net/http'

# :nodoc:
module Calc
  # costly operation, bigger scale costly it is
  def self.calc(scale)
    Array.new(scale * 100_000) { |i| i }.shuffle.sort
  end

  # costly operation with memoization
  def self.memoizable_calc(scale)
    @cache ||= {}
    @cache[scale] ||= calc(scale)
  end

  # network call, good candidate for batching
  def self.net_call(*queries)
    uri = URI("https://www.google.com/search?q=#{queries.join(' and ')}")
    Net::HTTP.get(uri) # => String
  end
end
