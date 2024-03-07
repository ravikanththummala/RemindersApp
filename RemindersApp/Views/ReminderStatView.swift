//
//  ReminderStatView.swift
//  RemindersApp
//
//  Created by Ravikanth  on 3/7/24.
//

import SwiftUI

struct ReminderStatView: View {
    
    let icon: String
    let title: String
    var count:Int?
    var iconColor:Color = .blue
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading,spacing: 10){
                    Image(systemName: icon)
                        .foregroundStyle(iconColor)
                        .font(.title)
                    
                    Text(title)
                        .opacity(0.8)
                }
                Spacer()
                if let count{
                    Text("\(count)")
                        .font(.largeTitle)
                }
                
            }.padding()
                .frame(maxWidth: .infinity)
                .background(.gray)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}

#Preview {
    ReminderStatView(icon: "calendar", title: "Today",count: 9)
}
