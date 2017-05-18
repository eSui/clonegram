class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :image, presence: true
  has_many :comments, dependent: :destroy
  validates_length_of :caption, :minimum => 5, :maximum => 200

  has_attached_file :image, styles: {:medium => "640x"}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
