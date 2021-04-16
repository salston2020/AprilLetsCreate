//
//  MoreDetailedBookingViewController.swift
//  Lets Create
//
//  Created by Sheena Alston on 4/8/21.
//

import UIKit
import FirebaseAuth
import Firebase

class MoreDetailedBookingViewController: UIViewController {
    
    var bookingList = [BookingModel]()
    
    var refBooking: DatabaseReference!
    
  
    var eventName: String = ""
    var eventType: String = ""
    var eventPrice: String = ""
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
  
    
        
    @IBOutlet weak var sampleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refBooking = Database.database().reference().child("Booking");
                    
        

          }
        
        

                  
                    
                }
               
    
            
        
