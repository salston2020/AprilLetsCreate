//
//  Booking.swift
//  Lets Create
//
//  Created by Sheena Alston on 4/6/21.
//

import UIKit
import Firebase





class Booking: UIViewController, UITableViewDelegate, UITableViewDataSource {
  

    @IBOutlet weak var bookingtb: UITableView!
        
    var bookingList = [BookingModel]()
    var myIndex = 0
    var eventName : String = ""
    var eventType : String = ""
    var eventPrice : String = ""
    
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! bookingCellTableViewCell
        
        let booking: BookingModel
        
        booking = bookingList[indexPath.row]
        
        cell.eventNameLabel.text = eventName
        cell.eventType.text = eventType
        cell.quoteTextLabel.text = eventPrice
        
        self.eventName = booking.eventName
        self.eventType = booking.eventType
        self.eventPrice = booking.eventPrice
        
        return cell
    }
    
    
    
    var refBooking: DatabaseReference!
    
   
    
    
    @IBAction func addNewBooking(_ sender: Any) {
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
            performSegue(withIdentifier: "addNewBooking", sender: indexPath.item)
        }    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookingtb.delegate = self
        bookingtb.dataSource = self
                
        refBooking = Database.database().reference().child("Booking");
        refBooking.observeSingleEvent(of: DataEventType.value, with:{ (snapshot) in
            if snapshot.childrenCount>0{
              
                
                for booking in snapshot.children.allObjects as! [DataSnapshot] {
                    let bookingObject = booking.value as? [String: AnyObject]
                    let eventName = bookingObject?["eventName"]
                    let eventType = bookingObject?["eventType"]
                    let eventPrice = bookingObject?["eventPrice"]
                    let eventID = bookingObject?["id"]
                
                    let booking = BookingModel(id: eventID as! UUID, eventName: eventName as! String, eventType: eventType as! String, eventPrice: eventPrice as! String)
                   
                    
                    
                    self.bookingList.append(booking)
            }
                    self.bookingtb.reloadData()
                
            }
            
            
        
       
        // Do any additional setup after loading the view.
    })
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        myIndex = indexPath.row
        
   
        
        print("You tapped cell number \(indexPath.row).")
        
        performSegue(withIdentifier: "moredetails", sender: indexPath.item)
       
    }

}

    
