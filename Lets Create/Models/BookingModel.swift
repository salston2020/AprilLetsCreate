//
//  BookingModel.swift
//  Lets Create
//
//  Created by Sheena Alston on 4/7/21.
//

import Foundation

class BookingModel{
    var id: String?
    var eventName: String?
    var eventType: String?
    var eventPrice: String?
    var eventZip: String?
    var eventHours: String?
    var additionalInformation: String?
    var postedBy: String?
    var eventDate: String?
    
         
    init(id: String?, eventName: String?, eventType: String?, eventPrice: String?, eventZip: String?, eventHours: String?, additionalInformation: String?, postedBy: String?, eventDate: String?){
        self.id = id;
        self.eventName = eventName;
        self.eventType = eventType;
        self.eventPrice = eventPrice;
        self.eventZip = eventZip;
        self.eventHours = eventHours;
        self.additionalInformation = additionalInformation;
        self.postedBy = postedBy;
        self.eventDate = eventDate;
        

}
    }

