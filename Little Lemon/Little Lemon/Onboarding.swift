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
                Hero()
                    .background(Color("brandGreen"))
                VStack {
                    NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                    VStack(alignment: .leading) {
                        Text("First Name *")
                        TextField("First Name", text: $firstName)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                            .autocorrectionDisabled()
                        Text("Last Name *")
                        TextField("Last Name", text: $lastName)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                            .autocorrectionDisabled()
                        Text("Email *")
                        TextField("Email Address", text: $email)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    .textFieldStyle(.roundedBorder)
                    Button {
                        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kLoggedIn)
                            isLoggedIn = true
                            
                            // Clear inputs for later login:
                            firstName = ""
                            lastName = ""
                            email = ""
                        }
                    } label: {
                        Text("Register")
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(firstName.isEmpty || lastName.isEmpty || email.isEmpty)
                    .tint(Color("brandYellow"))
                    .foregroundStyle(.black)
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                .padding()
                .onAppear() {
//                    if (UserDefaults.standard.value(forKey: kLoggedIn) as! Bool == true) {
                    if (UserDefaults.standard.bool(forKey: kLoggedIn)) {
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
}

#Preview {
    Onboarding()
}
