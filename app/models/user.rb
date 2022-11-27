class User < ApplicationRecord

  has_secure_password

  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :intro, {length: {maximum: 140}}

  def posts
    return Post.where(user_id: self.id)
  end
  
  def likers
    return Liker.where(user_id: self.id)
  end

end
