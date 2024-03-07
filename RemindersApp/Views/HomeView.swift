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
    @State private var isPresented: Bool = false
    @State private var search: String = ""

    
    var body: some View {
        NavigationStack {
            VStack {
                
               MyListsView(myLists: myListResults)
                
                //Spacer()
                
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
            }
            .onChange(of: search,perform: { newValue in
                
            })
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
        }.searchable(text: $search)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}
