# frozen_string_literal: true

class EvalRuby
  def eval_ruby(event, *ruby_code)
    ruby_code.delete('```ruby')
    ruby_code.delete('```')
    eval(ruby_code.join)
  end
end
