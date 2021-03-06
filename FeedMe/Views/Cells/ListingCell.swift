//
//  ListingCell.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/7/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import UIKit
import AlamofireImage

class ListingCell: UITableViewCell {
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var listingDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(place: Place, listing: Listing) {
        self.listingDescription.text = listing.listingDescription
        self.placeName.text = place.name
        self.placeAddress.text = place.address
        if let imageUrl = NSURL(string: place.imageUrl) {
            let filter = AspectScaledToFillSizeCircleFilter(size: self.placeImage.frame.size)
            self.placeImage.af_setImageWithURL(imageUrl, placeholderImage: nil, filter: filter)
        }
    }
}
