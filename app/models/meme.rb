class Meme < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :comments
  has_many :meme_tags
  has_many :tags, through: :meme_tags
  has_many :reactions
  belongs_to :group

  def update_reactions(user)
    user_reacted?(user) ? unreact(user) : react(user)
  end

  def reactions_message(user)
    if !user_reacted?(user)
      "<strong>#{self.reactions.count} people</strong> like this image".html_safe
    else
      "<strong>You</strong> and <strong>#{self.reactions.count - 1} other people</strong> like this image".html_safe
    end
  end

  def heart_class(user)
  if user_reacted?(user)
    "glyphicon glyphicon-heart"
  else
    "glyphicon glyphicon-heart-empty"
  end
end

  private
  def user_reacted?(user)
    self.reactions.where(user: user).any?
  end

  def react(user)
    self.reactions.create(user_id: user.id)
  end

  def unreact(user)
    self.reactions.find_by(user_id: user.id).destroy
  end

end
