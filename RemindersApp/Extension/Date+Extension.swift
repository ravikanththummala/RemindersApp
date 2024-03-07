//
//  Date+Extension.swift
//  RemindersApp
//
//  Created by Ravikanth  on 3/7/24.
//

import Foundation


extension Date {
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var isTommorow: Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(self)
    }
    
    var dateComponets: DateComponents {
        Calendar.current.dateComponents([.year,.month,.day,.hour], from: self)
    }
}
