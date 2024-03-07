//
//  ReminderStatsBuilder.swift
//  RemindersApp
//
//  Created by Ravikanth  on 3/7/24.
//

import Foundation
import SwiftUI

enum ReminderStatType {
    case today
    case all
    case completed
    case schudled
}
struct ReminderStatsValues {
    var todayCount:Int = 0
    var allCount:Int = 0
    var completeCount:Int = 0
    var SchudleCount:Int = 0

}

struct ReminderStatsBuilder {
    
    func build(_ myListResult: FetchedResults<MyList>) -> ReminderStatsValues{
        
        let remindersArray = myListResult.map{$0.reminderArray }.reduce([], +)
        
        let allCount = calculateAllCount(reminders: remindersArray)
        let completedCount = calculateAllCompleted(reminders: remindersArray)
        let todayCount = todayCount(reminders: remindersArray)
        let schudleCount = schudleCount(reminders: remindersArray)

        return ReminderStatsValues(todayCount: todayCount,
                                   allCount: allCount,
                                   completeCount: completedCount,
                                   SchudleCount: schudleCount)
    }
    
    
    private func todayCount(reminders:[Reminder]) -> Int{
        return reminders.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1 : result
        }
    }
    
    private func schudleCount(reminders:[Reminder]) -> Int{
        return reminders.reduce(0) { result, reminder in
            return ((reminder.reminderDate != nil || reminder.reminderTime != nil) && !reminder.isCompleted) ?  result + 1 : result
        }
    }
    
    private func calculateAllCount(reminders:[Reminder]) -> Int{
        return reminders.reduce(0) { result, reminder in
            return !reminder.isCompleted ? result + 1: result
        }
    }
    
    private func calculateAllCompleted(reminders:[Reminder]) -> Int{
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result + 1: result
        }
    }
}
