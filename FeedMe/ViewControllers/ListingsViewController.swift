//
//  ListingsViewController.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/7/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import UIKit
import Firebase

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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController
        destination.hidesBottomBarWhenPushed = true
    }

}

// MARK: - UITableViewDelegate
extension ListingsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - UITableViewDataSource
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
            cell.configure(place, listing: listing)
        })
    }
}
