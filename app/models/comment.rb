class Comment < ApplicationRecord
  include ActionView::Helpers::DateHelper
  belongs_to :user
  belongs_to :post

  def as_json
    {
    id: self.id,
    user_id: self.user_id,
    user_image_url: self.user.avatar.url,
    body: self.body,
    post_id: self.post_id,
    created_at: "#{distance_of_time_in_words(self.created_at, Time.now)} ago",
    user_name: self.user.full_name }
  end
end
