class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, through: :listings


  def city_openings(checkin, checkout)
    self.listings.each do |listing|
      listing.reservations.find do |reservation|
        if reservation.checkin.to_s > checkin || reservation.checkout.to_s < checkout
          reservation.listing
        end
      end
    end
  end

  def self.highest_ratio_res_to_listings
    self.all.max_by{|city| (city.reservations.size.to_f)/(city.listings.size.to_f)}
  end

  def self.most_res
    self.all.max_by{|city| city.reservations.size}
  end

end
