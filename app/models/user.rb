class User
  include Redis::Objects
  include ActiveModel::API
  include ActiveModel::SecurePassword
  include ActiveModel::Serializers::JSON

  attr_accessor :username, :password_digest, :recovery_password_digest
  validates :username, presence: true
  validate :unique_username
  validate :better_password
  # This is the default bcrypt secure password which is no longer recommended by OWASP.  Rather, should use Argon2
  has_secure_password

  # TODO: Catch common or easy-to-guess passwords  (such as 'P4ssw0rd123!'), possibly with rubygem 'password_blocklist'
  PASSWORD_RULES = 'Password must be at least 12 characters including numbers, upper and lowercase, and special characters.'

  def attributes
    {
      "username": nil,
      "password": nil,
    }
  end

  def find
    User.redis.get(redis_key)
  end

  def save
    if valid?
      User.redis.set(redis_key, password_digest)
    else
      validate!
    end
  end

  def destroy
      User.redis.del(redis_key)
  end

  private
  def unique_username
    errors.add(:base, 'Username is already taken') unless User.redis.get(redis_key).nil?
    User.redis.get(redis_key).nil?
  end

  def redis_key
    "user_#{username}"
  end

  def better_password
    if password.present?
      errors.add(:base, PASSWORD_RULES) unless password_match
    end
  end

  def password_match
    password =~/^(?=.{12,})(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+ =]).*$/
  end
end
