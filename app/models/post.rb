class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper
  mount_uploader :image, PostImageUploader

  belongs_to :user
  has_many :comments
  has_many :likes


  def as_json
    {
      id: self.id,
      body: self.body,
      image_url: self.image.url,
      user_id: self.user_id,
      user_name: self.user.full_name,
      created_at: "#{distance_of_time_in_words(self.created_at, Time.now)} ago",
      user_image_url: self.user.avatar.url,
      likes_count: self.likes.count,
      is_liked: true,
      comments_count: self.comments.count,
      comments: self.comments.as_json
    }
  end

end
