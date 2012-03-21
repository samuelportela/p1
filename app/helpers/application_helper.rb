module ApplicationHelper
  
  def auction_cover(auction, size = :small)
    if auction
      cover_list = cover_photos(auction.product.photos)

      if cover_list && cover_list.any?
        raw link_to(image_tag(cover_list.first.file(size)), auction_path(auction))
      else
        raw link_to(image_tag(Photo.new.file(size)), auction_path(auction))
      end
      
    else
      raw image_tag(Photo.new.file(size))
    end
  end
  
  def cover_photos(photos)
    photos.where(:is_cover => true)
  end
  
  def auction_last_bidder(auction)
    if auction && auction.last_bidder
      auction.last_bidder.display_name
    else
      '---'
    end
  end
  
end
