class User < ApplicationRecord

    devise :database_authenticatable, :registerable, :rememberable, :validatable,:omniauthable

    has_many :products
    has_many :orders

    validates :email, :presence => true
    validates :first_name, :presence => true

    def sales
        Order.where(author_id: self.id )
    end


    def self.from_omniauth(auth)
        user = where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
          user.first_name = auth.info.name
          user.last_name = ""
          user.provider = auth.provider
          user.uid = auth.uid
          user.email = auth.info.email
          user.password = Devise.friendly_token[0,20]
          user.github_token = auth.credentials.token
          user.github_login = auth.credentials.nickname
          user.github_avatar = auth.info.image
        end

        user.update(github_token: auth.credentials.token, github_login: auth.info.nickname,github_avatar: auth.info.image)
        return user

      end

    # instead of deleting, indicate the user requested a delete & timestamp it
     def soft_delete
       update_attribute(:deleted_at, Time.current)
     end

     def reactivate_user
        update_attribute(:deleted_at, nil)
      end

    # ensure user account is active
     def active_for_authentication?
       super && !deleted_at
     end

     # provide a custom message for a deleted account
     def inactive_message
     	!deleted_at ? super : :deleted_account
     end
end
