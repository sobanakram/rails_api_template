# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  phone_number           :string(255)
#  device_token           :string(255)
#  app_version            :integer
#  abstractable_type      :string(255)
#  abstractable_id        :integer
#  email                  :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)      default("email"), not null
#  uid                    :string(255)      default(""), not null
#  tokens                 :json
#
# Indexes
#
#  index_users_on_abstractable_type_and_abstractable_id  (abstractable_type,abstractable_id)
#  index_users_on_email                                  (email) UNIQUE
#  index_users_on_reset_password_token                   (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider                       (uid,provider) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, #:rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates_presence_of :app_version
  before_validation :init_uid

  def full_name
    return email if first_name.blank?

    "#{first_name} #{last_name}"
  end

  def self.from_social_provider(provider, user_params)
    where(provider: provider, uid: user_params['id']).first_or_create! do |user|
      user.password = Devise.friendly_token[0, 20]
      user.assign_attributes user_params.except('id')
    end
  end

  def ask_reset_password
    self.reset_password_token = Code::Generator.generate(self.email)
    self.reset_password_sent_at = DateTime.current
    UserMailer.send_reset_password_code(self).deliver_later if save
  end

  def valid_code?(code)
    self.reset_password_period_valid? && Code::Checker.check(self.reset_password_token, code)
  end

  def generate_reset_password_token
    set_reset_password_token
  end

  private

  def uses_email?
    provider == 'email' || email.present?
  end

  def init_uid
    self.uid = email if uid.blank? && provider == 'email'
  end
end
