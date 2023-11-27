//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Jeff Heppert on 11/26/23.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName)
    let lastName = UserDefaults.standard.string(forKey: kLastName)
    let email = UserDefaults.standard.string(forKey: kEmail)
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profileImage")
            Text("First Name: \(firstName ?? "")")
            Text("Last Name: \(lastName ?? "")")
            Text("Email: \(email ?? "")")
            Button("Logout") {
                UserDefaults.standard.setValue(false, forKey: kLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
