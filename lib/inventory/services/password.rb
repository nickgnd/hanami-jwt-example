# based on @jodosha's snippet shared on hanami gitter channel
#

require 'transproc/all'
require 'bcrypt'

class Password
  module Functions
    extend Transproc::Registry

    import Transproc::HashTransformations
    import :create, from: BCrypt::Password, as: :generate
    import :new,    from: BCrypt::Password, as: :new
  end

  def self.encrypt(data, key: :password, cost: cost_factor)
    transformation = t(:map_value, key, t(:generate, cost: cost))
      .>> t(:rename_keys, password: :password_digest)
      .>> t(:reject_keys, [:password_confirmation])

    transformation.(data)
  end

  def initialize(password_digest)
    @password_digest = t(:new).call(password_digest)
  end

  def ==(other)
    @password_digest == other
  end

  def self.cost_factor
    return 1 if Hanami.env == 'test'
    10
  end

  private

  def t(*args)
    Functions[*args]
  end

  def self.t(*args)
    Functions[*args]
  end

  private_class_method :t
end
