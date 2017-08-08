class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :tasks, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :price, presence: true, numericality: true

  has_attached_file :image, styles: { medium: "680x300>", thumb: "170x75>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def average_rating
    reviews.blank? ? 0 : reviews.average(:star).round(2)
  end

  def paypal_link(user)
    subscription = Subscription.find_or_create_by(user: user, course_id: id)
    {
      :business => "dwindy.stanza-facilitator@outlook.com",
      :cmd => "_xclick",
      :upload => 1,
      :amount => price,
      :notify_url => "http://24485205.ngrok.io/payment_notification",
      :item_name => title,
      :item_number => subscription.id,
      :quantity => 1,
      :return => "http://24485205.ngrok.io"
    }.to_query

  end
end
