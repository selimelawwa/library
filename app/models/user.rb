class User < ApplicationRecord
    has_many :orders, dependent: :destroy    
    
    before_create :encrypt_password
    before_save {self.email = email.downcase}
    validates :username, presence: true, uniqueness: {case_sensitive: false},
    length: { minimum: 5, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: {case_sensitive: false},
    length: { maximum: 105 }, format: {with: VALID_EMAIL_REGEX }
    #has_secure_password

    def encrypt_password
        if password.present?
          salt= Digest::SHA1.hexdigest("# We add #{email} as unique value")
          self.password= Digest::SHA1.hexdigest("Adding #{salt} to #{password}")
        end
      end
end
