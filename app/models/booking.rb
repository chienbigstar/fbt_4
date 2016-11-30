class Booking < ApplicationRecord
  include PublicActivity::Common

  attr_accessor :public_token

  has_many :activities, as: :trackable,
    class_name: PublicActivity::Activity.name, dependent: :destroy

  belongs_to :discount
  belongs_to :tour
  belongs_to :user

  enum status: [:waiting_pay, :processing, :disapproached, :approached]
  
  validates :tour_id, presence: true, format: {with: /\A[1-9]/i}
  validates :number_member, presence: true, format: {with: /\A[1-9]/i}
  validate :available_tour

  filterrific(
    default_filter_params: {
      sorted_by: "created_at desc",
      search_status: "all"
    },
    available_filters: [
      :sorted_by,
      :search_user,
      :search_tour,
      :search_status,
      :date_range
    ]
  )

  scope :search_user, -> name{joins(:user).where("name like ?", "%#{name}%")}
  scope :search_tour, -> name{joins(:tour).where("name like ?", "%#{name}%")}
  scope :sorted_by, -> sort_key {order sort_key}
  scope :search_status, -> status{where(status: status) unless status == "all" }
  scope :date_range, -> value{
    dates = value.split " -> "
    where("created_at >= ? AND created_at <= ?", dates[0], dates[1])
  }
  scope :bookings, -> user{where user_id: user.id}

  def available_tour
    @tour = Tour.find_by_id tour_id
    if @tour
      self.total_money = number_member * @tour.price
      self.payment_token = Booking.new_token
    else
      errors.add :base, I18n.t("tours.invalid_tour")
    end
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def options_for_sorted_by
      [
        [I18n.t("admin.bookings.created_at_desc"), "created_at desc"],
        [I18n.t("admin.bookings.created_at_asc"), "created_at asc"],
      ]
    end

    def options_for_status
      {all: :all}.merge(Booking.statuses).collect{|key, value| [key, key]}
    end
  end
end
