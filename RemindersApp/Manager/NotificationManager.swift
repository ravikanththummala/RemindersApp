//
//  NotificationManager.swift
//  RemindersApp
//
//  Created by Ravikanth  on 3/7/24.
//

import Foundation
import UserNotifications

struct UserData {
    let title: String?
    let body: String?
    let date:Date?
    let time:Date?
}
class NotificationManager {
    
    static func schudleNotification(userData: UserData){
        let content = UNMutableNotificationContent()
        content.title = userData.title  ??  ""
        content.body = userData.body  ??  ""

        var dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: userData.date ??  Date())
        
        if let reminderTime = userData.time {
            let reminderTmeDateComponent = reminderTime.dateComponets
            dateComponents.hour = reminderTmeDateComponent.hour
            dateComponents.minute = reminderTmeDateComponent.minute
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: " Reminder Notification \(dateComponents)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
}
