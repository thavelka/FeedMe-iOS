//
//  SelectPlaceViewController.swift
//  FeedMe
//
//  Created by Tim Havelka on 8/11/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import UIKit
import Firebase

class SelectPlaceViewController: UIViewController {
    
    var places = [Place]()
    var ref: FIRDatabaseReference!
    var handle: UInt = 0
    var searchText: String = ""
    var filteredPlaces: [Place] {
        if !searchText.isEmpty {
            return places.filter(){$0.name.localizedCaseInsensitiveContainsString(searchText)}
        } else {
            return places
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        places.removeAll()
        handle = self.ref.child("places").observeEventType(.ChildAdded, withBlock: {
            snapshot in
            self.places.append(Place(id: snapshot.key, values: snapshot.value as! [String: AnyObject]))
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
        if segue.identifier == "createListingSegue", let place = sender as? Place {
            let destination = segue.destinationViewController as! CreateListingViewController
            destination.place = place
        }
    }
    
}

// MARK: - UITableViewDelegate
extension SelectPlaceViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard filteredPlaces.count > 0 else { return }
        let place = filteredPlaces[indexPath.row]
        self.performSegueWithIdentifier("createListingSegue", sender: place)
    }
}

// MARK: - UITableViewDataSource
extension SelectPlaceViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPlaces.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell", forIndexPath: indexPath) as! PlaceCell
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: PlaceCell, atIndexPath indexPath: NSIndexPath) {
        guard filteredPlaces.count > 0 else { return }
        let place = filteredPlaces[indexPath.row]
        cell.configure(place)
    }
}

// MARK: - UISearchBarDelegate
extension SelectPlaceViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        self.tableView.reloadData()
    }
}
