//
//  ListingsViewController.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/7/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI
import AlamofireImage

class ListingsViewController: UIViewController {
    
    enum State {
        case Food, Drinks, Favorites
    }
    
    var listings = [Listing]()
    var state: State?
    var ref: FIRDatabaseReference!
    var handle: UInt = 0
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        listings.removeAll()
        handle = self.ref.child("listings").observeEventType(.ChildAdded, withBlock: {
            snapshot in
            self.listings.append(Listing(id: snapshot.key, values: snapshot.value as! [String: AnyObject]))
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidDisappear(animated: Bool) {
        ref.removeObserverWithHandle(self.handle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableViewDelegate
extension ListingsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}

extension ListingsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListingCell", forIndexPath: indexPath) as! ListingCell
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: ListingCell, atIndexPath indexPath: NSIndexPath) {
        let listing = listings[indexPath.row]
        self.ref.child("places").child(listing.placeId).observeSingleEventOfType(.Value, withBlock: {
            snapshot in
            let place = Place(id: listing.placeId, values: snapshot.value! as! [String : AnyObject])
            cell.placeName.text = place.name
            cell.placeAddress.text = place.address
            if let imageUrl = NSURL(string: place.imageUrl) {
                let filter = AspectScaledToFillSizeCircleFilter(size: cell.placeImage.frame.size)
                cell.placeImage.af_setImageWithURL(imageUrl, placeholderImage: nil, filter: filter)
            }
        })
        cell.listingDescription.text = listing.listingDescription
    }
}
