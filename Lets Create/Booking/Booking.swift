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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookingList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! bookingCellTableViewCell
        
        let booking: BookingModel
        
        booking = bookingList[indexPath.row]
        
        cell.eventNameLabel.text = booking.eventName
        cell.eventType.text = booking.eventType
        cell.quoteTextLabel.text = booking.eventPrice
        
        return cell
    }
    
    var refBooking: DatabaseReference!
    
   
    
    
    @IBAction func addNewBooking(_ sender: Any) {
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            performSegue(withIdentifier: "addNewBooking", sender: indexPath.item)
        }    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refBooking = Database.database().reference().child("Booking");
        refBooking.observeSingleEvent(of: DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.bookingList.removeAll()
                
                for booking in snapshot.children.allObjects as! [DataSnapshot] {
                    let bookingObject = booking.value as? [String: AnyObject]
                    let eventName = bookingObject?["eventName"]
                    let eventType = bookingObject?["eventType"]
                    let eventPrice = bookingObject?["eventPrice"]
                    let eventID = bookingObject?["id"]
                
                    let booking = BookingModel(id: eventID as! String?, eventName: eventName as! String?, eventType: eventType as! String?, eventPrice: eventPrice as! String?)
                   
                    self.bookingList.append(booking)
            }
                self.bookingtb.reloadData()
            }
        })
        
       
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
})



func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    myIndex = indexPath.row
    

    
    print("You tapped cell number \(indexPath.row).")
    
    performSegue(withIdentifier: "moredetails", sender: indexPath.item)
   
}



