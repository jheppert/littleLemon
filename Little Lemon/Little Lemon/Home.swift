//
//  Home.swift
//  Little Lemon
//
//  Created by Jeff Heppert on 11/25/23.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden()
//        .toolbarBackground(.white, for: .automatic)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("littleLemonLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 35)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Image("profileImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 35)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    Home()
}
