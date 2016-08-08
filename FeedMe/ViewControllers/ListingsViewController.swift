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

class ListingsViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    var dataSource: FirebaseTableViewDataSource?
    
    enum State {
        case Food, Drinks, Favorites
    }
    
    @IBOutlet weak var tableView: UITableView!
    var listings = [Listing]()
    var state: State?

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        
        let query = (ref?.child("listings").queryLimitedToFirst(100))!
        
        dataSource = FirebaseTableViewDataSource.init(query: query, modelClass: Listing.self, prototypeReuseIdentifier: "ListingCell", view: self.tableView)
        
        dataSource?.populateCellWithBlock(){
            let cell = $0 as! ListingCell
            let listing = $1 as! Listing
            
            self.ref.child("places").child(listing.placeId).observeSingleEventOfType(.Value, withBlock: {
                snapshot in
                print(snapshot.value)
                let place = Place(id: listing.placeId, values: snapshot.value! as! [String : AnyObject])
                cell.placeName.text = place.name
                cell.placeAddress.text = place.address
            })
            cell.listingDescription.text = listing.listingDescription
        }
        
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
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
