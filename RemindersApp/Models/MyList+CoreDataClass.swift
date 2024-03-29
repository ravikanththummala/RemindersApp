//
//  MyList+CoreDataClass.swift
//  RemindersApp
//
//  Created by Ravikanth  on 7/5/24.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    var reminderArray: [Reminder]{
        reminders?.allObjects.compactMap{($0 as! Reminder)} ?? []
    }
}
