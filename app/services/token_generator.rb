class TokenGenerator
  def self.generate
    Base32.random_base32(6)[0..5].downcase
  end
end
