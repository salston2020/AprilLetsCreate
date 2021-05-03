//
//  Booking.swift
//  Lets Create
//
//  Created by Sheena Alston on 4/6/21.
//

import UIKit
import Firebase

class Booking: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
  

    @IBOutlet weak var bookingtb: UITableView!
    let searchController = UISearchController()
    var filteredBookings = [BookingModel]()
    var bookingList = [BookingModel]()
    

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            if(searchController.isActive)
            {
                return filteredBookings.count
            }
        return bookingList.count
    }
    
   
                
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! bookingCellTableViewCell
        
        let booking: BookingModel!
        
        if(searchController.isActive)
        {
            booking = filteredBookings[indexPath.row]
        }
        else
        {
            booking = bookingList[indexPath.row]
        }
        
       
        
        cell.eventNameLabel?.text = booking.eventName
        cell.eventType.text = booking.eventType
        cell.quoteTextLabel.text = booking.eventPrice
        cell.eventDate.text = booking.eventDate
        cell.zipCellLabel.text = booking.eventZip
        
        return cell
    }
    
    var refBooking: DatabaseReference!
    
   
    
    
    @IBAction func addNewBooking(_ sender: Any) {
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            performSegue(withIdentifier: "addNewBooking", sender: indexPath.row)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooking()
        initSearchController()
        configureRefreshControl ()
     
        
        
        self.bookingtb.delegate = self
        self.bookingtb.dataSource = self
        
   
    }
    
    func initSearchController()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["Zipcode"]
        searchController.searchBar.placeholder = "Search By Zipcode "
        searchController.searchBar.delegate = self
    }
    
        private func getBooking() {
            
            refBooking = Database.database().reference().child("Booking");
        refBooking.observeSingleEvent(of: DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.bookingList.removeAll()
                
                for booking in snapshot.children.allObjects as! [DataSnapshot] {
                    let bookingObject = booking.value as? [String: AnyObject]
                    
                    let eventName = bookingObject?["eventName"]
                    let eventType = bookingObject?["eventType"]
                    let eventPrice = bookingObject?["eventPrice"]
                    let eventZip = bookingObject?["eventZip"]
                    let eventHours = bookingObject?["eventHours"]
                    let additionalInformation = bookingObject?["additionalInformation"]
                    let postedBy = bookingObject?["postedBy"]
                    let eventID = bookingObject?["id"]
                    let eventDate = bookingObject?["eventDate"]
                    
                    
                
                    let booking = BookingModel(id: eventID as! String?, eventName: eventName as! String?, eventType: eventType as! String?, eventPrice: eventPrice as! String?, eventZip: eventZip as! String?, eventHours: eventHours as! String?, additionalInformation: additionalInformation as! String?, postedBy: postedBy as! String?, eventDate: eventDate as! String?)
                    
                    
                   
                    self.bookingList.append(booking)
            }
                DispatchQueue.main.async {
                    self.bookingtb.reloadData()
                            }
               
            }
        })
    
    }

    
        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "EventDetails", sender: self)
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EventDetails") {
            if let detailsVC = segue.destination as? MoreDetailedBookingViewController {
                if let indexPath = self.bookingtb.indexPathForSelectedRow {
                    let booking = bookingList[indexPath.row]
                    if let cell = self.bookingtb.cellForRow(at: indexPath) as? bookingCellTableViewCell {
                        detailsVC.eventName = cell.eventNameLabel.text!
                    }
                    detailsVC.eventName = booking.eventName!
                    detailsVC.eventType = booking.eventType!
                    detailsVC.eventPrice = "$ " + booking.eventPrice!
                    detailsVC.eventZip = booking.eventZip!
                    detailsVC.eventHours = booking.eventHours!
                    detailsVC.postedBy = booking.postedBy!
                    detailsVC.eventDate = booking.eventDate!
                                
                    
                    detailsVC.additionalInformation = booking.additionalInformation!
        }
    

            }
        }
  }
   
   
    
    func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
       bookingtb.refreshControl = UIRefreshControl()
        bookingtb.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        
        getBooking()
            print("refreshed")

       // Dismiss the refresh control.
       DispatchQueue.main.async {
          self.bookingtb.refreshControl?.endRefreshing()
       }
    }
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
            self.bookingList.remove(at: indexPath.row)
            self.bookingtb.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        
        // here set your image and background color
        deleteAction.image = UIImage(named: "deletebin")
        deleteAction.backgroundColor = .gray
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
            self.bookingList.remove(at: indexPath.row)
            self.bookingtb.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "Zipcode")
    {
        filteredBookings = bookingList.filter
        {
            booking in
            let scopeMatch = (scopeButton == "Zipcode" || booking.eventZip!.lowercased().contains(scopeButton.lowercased()))
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = booking.eventZip!.lowercased().contains(searchText.lowercased())
                
                
                return scopeMatch && searchTextMatch
            }
            else
            {
                return scopeMatch
            }
            
            
        }
        bookingtb.reloadData()
    }
}

    

