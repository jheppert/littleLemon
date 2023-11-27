//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Jeff Heppert on 11/25/23.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
//                navigationDestination(isPresented: $isLoggedIn) {
//                    Home()
//                }
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email Address", text: $email)
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kLoggedIn)
                        isLoggedIn = true
                    } else {
                        
                    }
                }
            }
            .padding()
            .onAppear() {
                if (UserDefaults.standard.value(forKey: kLoggedIn) as! Bool == true) {
                    isLoggedIn = true
                    print("Logged In")
                } else {
                    isLoggedIn = false
                    print("Logged out")
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
