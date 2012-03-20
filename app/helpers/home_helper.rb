module HomeHelper
  
  def auction_cover(auction, size = :small)
    cover_list = cover_photos(auction.product.photos)

    if cover_list && cover_list.any?
      raw link_to(image_tag(cover_list.first.file(size)), auction_path(auction))
    else
      raw link_to(image_tag(Photo.new.file(size)), auction_path(auction))
    end
  end
  
  def cover_photos(photos)
    photos.where(:is_cover => true)
  end
  
end
