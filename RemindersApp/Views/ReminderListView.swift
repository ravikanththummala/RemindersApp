//
//  ReminderListView.swift
//  RemindersApp
//
//  Created by Ravikanth  on 7/5/24.
//

import SwiftUI

struct ReminderListView: View {
    
    @State private var selectedReminder:Reminder?
    @State private var showReminderDetail:Bool = false
    
    let reminders: FetchedResults<Reminder>
    
    private func reminderCheckedChnaged(reminder: Reminder,isCompletd:Bool){
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = !reminder.isCompleted
        do {
           let _  =  try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        }catch{
            print(error)
        }
    }
    
    private func isReminderSelected(_ reminder:Reminder) -> Bool{
        selectedReminder?.objectID == reminder.objectID
    }
    
    private func deleteReminder(_ indexSet:IndexSet){
        indexSet.forEach { index in
            let reminder = reminders[index]
            do{
                try ReminderService.deleteReminder(reminder)
            }catch {
                print("Error in delete \(error)")
            }
        }
    }
    
    var body: some View {
        VStack {
            List{
                ForEach(reminders) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)){ event in
                        switch event {
                        case .onInfo:
                            print("On Info")
                            showReminderDetail = true
                        case .onCheckedChange(let reminder,let isCompletd):
                            reminderCheckedChnaged(reminder: reminder,isCompletd:isCompletd)
                            print("On Changed")
                        case .onSelect(let reminder):
                            selectedReminder = reminder
                        }
                    }
                }
                .onDelete(perform: deleteReminder)
            }

        }
        .sheet(isPresented:$showReminderDetail){
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}


struct ReminderListView_Previews: PreviewProvider {
    
    struct ReminderListContainer:View {
        @FetchRequest(sortDescriptors: [])
        private var reminders: FetchedResults<Reminder>

        var body: some View {
            ReminderListView(reminders: reminders)

        }
    }
    
    static var previews: some View {
        ReminderListContainer()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}
