module Code
  class Generator
    def self.generate(text, digits_count = 6)
      # TODO: Add Algorithm to generate secure code
      code = SecureRandom.rand(100000..999999)
      code
    end
  end

  class Checker
    def self.check(token, code)
      # TODO: Add Algorithm to check secure code
      token == code
    end
  end
end