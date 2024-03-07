//
//  SelectListView.swift
//  RemindersApp
//
//  Created by Ravikanth  on 3/7/24.
//

import SwiftUI

struct SelectListView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListFetchResults: FetchedResults<MyList>
    @Binding var selectList: MyList?
    
    var body: some View {
        
        List(myListFetchResults){ myList in
            HStack {
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundStyle(Color(myList.color))
                
                    Text(myList.name)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectList = myList
                }
                
                Spacer()
                
                if(selectList == myList){
                    Image(systemName: "checkmark")
                }

            }
            
        }
    }
}

#Preview {
    SelectListView(selectList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
