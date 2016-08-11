//
//  CreateListingViewController.swift
//  FeedMe
//
//  Created by Tim Havelka on 8/11/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import UIKit
import Firebase
import AlamofireImage

class CreateListingViewController: UIViewController {
    
    enum Day: Int {
        case Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    }
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var listingTypeSegment: UISegmentedControl!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    
    @IBAction func touchedSundayButton(sender: AnyObject) {
        toggleButton(sundayButton, day: .Sunday)
    }
    @IBAction func touchedMondayButton(sender: AnyObject) {
        toggleButton(mondayButton, day: .Monday)
    }
    @IBAction func touchedTuesdayButton(sender: AnyObject) {
        toggleButton(tuesdayButton, day: .Tuesday)
    }
    @IBAction func touchedWednesdayButton(sender: AnyObject) {
        toggleButton(wednesdayButton, day: .Wednesday)
    }
    @IBAction func touchedThursdayButton(sender: AnyObject) {
        toggleButton(thursdayButton, day: .Thursday)
    }
    @IBAction func touchedFridayButton(sender: AnyObject) {
        toggleButton(fridayButton, day: .Friday)
    }
    @IBAction func touchedSaturdayButton(sender: AnyObject) {
        toggleButton(saturdayButton, day: .Saturday)
    }
    @IBAction func submitButton(sender: AnyObject) {
        createListing()
        navigationController?.popViewControllerAnimated(true)
        navigationController?.popViewControllerAnimated(true)
    }
    
    var ref: FIRDatabaseReference!
    var place: Place?
    var days = [String: Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        if let urlString = place?.imageUrl, let url = NSURL(string: urlString) {
            placeImage.af_setImageWithURL(url)
        }
        placeName.text = place?.name
        placeAddress.text = place?.address
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createListing() {
        let listing = Listing()
        listing.id = ref.child("listings").childByAutoId().key
        listing.userId = FIRAuth.auth()?.currentUser?.uid ?? ""
        listing.placeId = place?.id ?? ""
        listing.cityId = place?.cityId ?? ""
        listing.listingDescription = descriptionField.text
        listing.type = listingTypeSegment.selectedSegmentIndex == 0 ? .Food : .Drink
        listing.days = self.days
        let updates = listing.getValues()
        self.ref.updateChildValues(updates)
    }
    
    func toggleButton(button: UIButton, day: Day) {
        let dayString = String(day.rawValue)
        let selected = !(self.days[dayString] ?? false)
        self.days[dayString] = selected
        button.setTitleColor((selected ? UIColor.blueColor() : UIColor.lightGrayColor()), forState: .Normal)
    }
}
