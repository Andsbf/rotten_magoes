class Movie < ActiveRecord::Base

  scope :under_90_min,  -> { where('runtime_in_minutes < ?', 90) }
  scope :btw_90_and_120_min, -> { where(runtime_in_minutes: 90..120) }
  scope :over_120_min, -> { where('runtime_in_minutes > ?', 120) }
    
  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :image,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future


  mount_uploader :image, ImageUploader

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end


end
