//
//  ContentView.swift
//  RemindersApp
//
//  Created by Ravikanth  on 7/5/24.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>

    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.reminderByStatType(statType: .today))
    private var todayResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.reminderByStatType(statType: .schudled))
    private var scheduledResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.reminderByStatType(statType: .all))
    private var allResults: FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: ReminderService.reminderByStatType(statType: .completed))
    private var completedResults: FetchedResults<Reminder>
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatValues = ReminderStatsValues()

    
    @State private var isPresented: Bool = false
    @State private var searching: Bool = false
    @State private var search: String = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    
                    HStack{
                        NavigationLink {
                            ReminderListView(reminders: todayResults)
                        } label: {
                            ReminderStatView(icon: "calendar", title: "Today",count: reminderStatValues.todayCount)
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: scheduledResults)
                        } label: {
                            ReminderStatView(icon: "calendar.circle.fill", title: "Scheduled",count: reminderStatValues.SchudleCount,iconColor: .red)
                        }
                    }
                    
                    HStack{
                        
                        
                        NavigationLink {
                            ReminderListView(reminders: completedResults)
                        } label: {
                            ReminderStatView(icon: "checkmark.circle.fill", title: "Completed",count: reminderStatValues.completeCount,iconColor: Color.brown)
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: allResults)
                        } label: {
                            ReminderStatView(icon: "tray.circle.fill", title: "All",count: reminderStatValues.allCount,iconColor: .gray)
                        }
                        
                    }
                    
                    Text("My List")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    
                    MyListsView(myLists: myListResults)
                                        
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }.padding()
                }
            }
            .onChange(of: search,perform: { newValue in
                searching = !search.isEmpty ? true : false
                searchResults.nsPredicate = ReminderService.getRemindersBySearchTerm(search).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResults)
                    .opacity(searching ? 1.0: 0.0)
            })
            .onAppear{
                reminderStatValues = reminderStatsBuilder.build(myListResults)
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Reminders")
        }.searchable(text: $search)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}
