//
//  ReminderDetailView.swift
//  RemindersApp
//
//  Created by Ravikanth  on 3/7/24.
//

import SwiftUI

struct ReminderDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var reminder: Reminder
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    
    private var isFormValid:Bool {
        editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List{
                    Section{
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    
                    Section{
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundStyle(.red)
                        }
                        
                        if editConfig.hasDate{
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundStyle(.red)
                        }
                        
                        if editConfig.hasTime{
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        
                        
                    }
                    
                    Section {
                        
                        NavigationLink {
                            SelectListView(selectList: $reminder.list)
                        } label: {
                            HStack{
                                Text("List")
                                Spacer()
                                Text(reminder.list!.name)
                            }
                        }
                    }
                    .onChange(of: editConfig.reminderDate) { hasDate in
                        if hasDate != nil {
                            editConfig.reminderDate = Date()
                        }
                    }           
                    .onChange(of: editConfig.reminderTime) { hasTime in
                        if hasTime != nil {
                            editConfig.reminderTime = Date()
                        }
                    }
                    
                    
                }.listStyle(.insetGrouped)
            }.onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        do {
                            let updated = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                            
                            if updated{
                                // Check if we should even schudle a notification
                                if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                    let userData = UserData(title: reminder.title, body: reminder.notes, date: reminder.reminderDate, time: reminder.reminderTime)
                                    NotificationManager.schudleNotification(userData: userData)
                                }
                            }
                        }
                        catch{
                            print("Error in updating ")
                        }
                        
                    dismiss()
                    }.disabled(isFormValid)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ReminderDetailView(reminder: .constant(PreviewData.reminder))
    }
}
