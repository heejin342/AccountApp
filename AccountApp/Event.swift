//
//  Event.swift
//  AccountApp
//
//  Created by 김희진 on 2021/07/20.
//

import Foundation

var eventsList = [Event]()

class Event {

    var type: String!
    var id: Int!
    var name: String!
    var date: Date!
    var money: String!


    func eventsForDate(date: Date) -> [Event]
    {
        
        var daysEvents = [Event]()
        var days = [String]()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"

        for event in eventsList
        
        {
            if(Calendar.current.isDate(event.date, inSameDayAs: date)){
                                
                daysEvents.append(event)
                days.append(dateFormatter.string(from: event.date))
            }
         
        }
        
        return daysEvents
    }
    
}
