//
//  PlaceCell.swift
//  FeedMe
//
//  Created by Tim Havelka on 8/11/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import UIKit
import AlamofireImage

class PlaceCell: UITableViewCell {
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(place: Place) {
        self.nameLabel.text = place.name
        self.addressLabel.text = place.address
        if let imageUrl = NSURL(string: place.imageUrl) {
            let filter = AspectScaledToFillSizeCircleFilter(size: self.placeImage.frame.size)
            self.placeImage.af_setImageWithURL(imageUrl, placeholderImage: nil, filter: filter)
        }
    }

}
