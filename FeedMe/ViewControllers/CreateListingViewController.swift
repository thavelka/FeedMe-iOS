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
    @IBOutlet weak var descriptionWarning: UILabel!
    @IBOutlet weak var dayWarning: UILabel!
    
    
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
        let hasDescription = descriptionField.text.characters.count > 0
        let hasDays = days.values.contains({$0})
        descriptionWarning.hidden = hasDescription
        dayWarning.hidden = hasDays
        guard hasDescription && hasDays else {
            return
        }
        createListing()
        navigationController?.popToRootViewControllerAnimated(true)
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
        listing.userId = FIRAuth.auth()?.currentUser?.uid ?? ""
        listing.placeId = place?.id ?? ""
        listing.cityId = place?.cityId ?? ""
        listing.listingDescription = descriptionField.text
        listing.type = listingTypeSegment.selectedSegmentIndex == 0 ? .Food : .Drink
        listing.days = self.days
        listing.save()
    }
    
    func toggleButton(button: UIButton, day: Day) {
        let dayString = String(day.rawValue)
        let selected = !(self.days[dayString] ?? false)
        self.days[dayString] = selected
        button.setTitleColor((selected ? UIColor.blueColor() : UIColor.lightGrayColor()), forState: .Normal)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Dismiss keyboard if user touched outside of text field
        descriptionField.resignFirstResponder()
    }
}

extension CreateListingViewController: UITextViewDelegate {
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        // If return key pressed, dismiss keyboard
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        // Allow edit if char count < 256
        let newText = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
        return newText.characters.count < 256
    }
}
