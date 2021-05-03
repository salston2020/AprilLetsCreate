//
//  BookingViewController.swift
//  Lets Create
//
//  Created by Sheena Alston on 4/6/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Firebase

class BookingViewController: UIViewController, UITextFieldDelegate {

    
    var refBooking: DatabaseReference!
    var ProfileViewModelType = [ProfileViewModel]()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var EventType: UITextField!
    @IBOutlet weak var quoteText: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var eventhours: UITextField!
    @IBOutlet weak var additionalEvent: UITextView!
    
    @IBOutlet weak var postedBy: UITextField!
 
    @IBOutlet weak var eventDate: UITextField!
  
    
    @IBOutlet weak var addEventButton: UIButton!
    
    
    
    @IBOutlet weak var actionLabel: UILabel!
    
    
    let datePicker = UIDatePicker()
    
    @IBAction func actionButtonPressed(_ sender: Any) {
        addBooking()
        dismiss (animated: true, completion: nil)
    
       
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            super.dismiss(animated: flag, completion: completion)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        addEventButton.isUserInteractionEnabled = true
        nameTextField.delegate = self
        if ((nameTextField.text?.isEmpty) != nil){
            addEventButton.isUserInteractionEnabled = false
            self.actionLabel.text = "message"
            }
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .compact
        
            self.eventDate.datePicker(target: self,
                                            doneAction: #selector(doneAction),
                                            cancelAction: #selector(cancelAction),
                                            datePickerMode: .date)
          
        refBooking = Database.database().reference().child("Booking");
        // Do any additional setup after loading the view.
         
        }
    }
    
    
    func addBooking(){
       

       let key = refBooking.childByAutoId().key
       
       let booking = ["id": key,
                      "eventName": nameTextField.text! as String,
                      "eventType": EventType.text! as String,
                      "eventPrice": quoteText.text! as String,
                      "eventZip": zipCode.text! as String,
                      "eventHours": eventhours.text! as String,
                      "postedBy": postedBy.text! as String,
                      "eventDate": eventDate.text! as String,
                      "additionalInformation": additionalEvent.text! as String,]
       
        
       
       refBooking.child(key!).setValue(booking)
       actionLabel.text = "Event Added"
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
                // Get the new view controller using segue.destination.
                // Pass the selected object to the new view controller.
            }
        if let text = nameTextField.text, text.isEmpty {
            actionLabel.text = "Service Needed is field is empty"
            addEventButton.isEnabled = true
           } else {
            addEventButton.isEnabled = false
            
           }
        }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = (nameTextField.text! as NSString).replacingCharacters(in: range, with: string)

        if !text.isEmpty{
            addEventButton.isUserInteractionEnabled = true
                 } else {
            addEventButton.isUserInteractionEnabled = false
     
    }
        return true
    }
    
    
    
    @objc
    func cancelAction() {
        self.eventDate.resignFirstResponder()
    }

    @objc
    func doneAction() {
        if let datePickerView = self.eventDate.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.eventDate.text = dateString
            
            print(datePickerView.date)
            print(dateString)
            
            self.eventDate.resignFirstResponder()
        }
    }
}

extension UITextField {
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.datePickerMode = datePickerMode
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
    

    
        


}
