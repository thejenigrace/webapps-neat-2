class User < ActiveRecord::Base
  def self.create_user(name, email, password, password_confirm, confirm_token)
    return false if password != password_confirm
    return false if User.where(email: email).to_a.size > 0
    salt = BCrypt::Engine.generate_salt
    hashed_password = BCrypt::Engine.hash_secret(password, salt)
    new_user = User.create(name: name, email: email, password: hashed_password, salt: salt, email_confirmed: false, confirm_token: confirm_token)
    new_user
  end

  def self.authenticate(email, password)
    user = User.where(email: email).first
    if user.present? && user.password == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
end
