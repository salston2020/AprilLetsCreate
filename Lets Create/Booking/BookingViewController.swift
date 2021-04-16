//
//  BookingViewController.swift
//  Lets Create
//
//  Created by Sheena Alston on 4/6/21.
//

import UIKit
import Firebase

class BookingViewController: UIViewController {

    
    var refBooking: DatabaseReference!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var EventType: UITextField!
    @IBOutlet weak var quoteText: UITextField!

    
    @IBOutlet weak var actionLabel: UILabel!
    
    @IBAction func actionButtonPressed(_ sender: Any) {
        
        addBooking()
        

        self.dismiss(animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        refBooking = Database.database().reference().child("Booking");
        // Do any additional setup after loading the view.
    }
    
    func addBooking(){
        let key = refBooking.childByAutoId().key
        
        let booking = ["id": key,
                       "eventName": nameTextField.text! as String,
                       "eventType": EventType.text! as String,
                       "eventPrice": quoteText.text! as String,
        ]
        
        refBooking.child(key!).setValue(booking)
        actionLabel.text = "Event Added"
    }
  //  guard let key = ref.child("posts").childByAutoId().key else { return }
 //   let post = ["uid": userID,
    //            "author": username,
   //             "title": title,
   //             "body": body]
  //  let childUpdates = ["/posts/\(key)": post,
    //                    "/user-posts/\(userID)/\(key)/": post]
   // ref.updateChildValues(childUpdates)
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
     }
    
    }

