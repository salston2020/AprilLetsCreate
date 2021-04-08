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
    init(id: String?, eventName: String?, eventType: String?, eventPrice: String?){
        self.id = id;
        self.eventName = eventName;
        self.eventType = eventType;
        self.eventPrice = eventPrice;
    }
}
