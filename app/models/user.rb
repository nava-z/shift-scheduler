class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :authentication_keys => [:login]

  has_many :volunteer_commitments

  has_many :user_skills
  has_many :skills, through: :user_skills

  has_many :user_issues
  has_many :issues, through: :user_issues

  validates :username, presence: true
  validates_uniqueness_of :username, message: 'An account with that username already exists'
  validates_uniqueness_of :email, message: 'An account with that email address already exists'

  attr_accessor :login

  def signed_up_for shift
    VolunteerCommitment.exists? user: self, shift: shift
  end

  def self.find_first_by_auth_conditions conditions, opts = {}
    if conditions.has_key? :reset_password_token
      User.find_by_reset_password_token conditions[:reset_password_token]
    else
      User.find_by_username(conditions[:login]) || User.find_by_email(conditions[:login])
    end


  end

  # Return true is this user is linked with the given issue
  def has_issue? issue
    UserIssue.exists? user: self, issue: issue
  end
end
