//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Jeff Heppert on 11/26/23.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State private var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Personal Information")
                .font(.title3)
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            Image("profileImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            Text("First Name")
                .font(.subheadline)
            TextField("First Name", text: $firstName)
                .textFieldStyle(.roundedBorder)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            Text("Last Name")
                .font(.subheadline)
            TextField("Last Name", text: $lastName)
                .textFieldStyle(.roundedBorder)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            Text("Email")
                .font(.subheadline)
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
//            MARK: Save Buttons
            HStack {
                Button {
                    firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                    lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
                    email = UserDefaults.standard.string(forKey: kEmail) ?? ""
                    
                } label: {
                    Text("Discard Changes")
                        .frame(maxWidth: .infinity)
                }
                .tint(Color("lightBackground"))
                .foregroundStyle(.red)
                .buttonStyle(.borderedProminent)
                
                Button {
                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                    UserDefaults.standard.set(lastName, forKey: kLastName)
                    UserDefaults.standard.set(email, forKey: kEmail)
                } label: {
                    Text("Save Changes")
                        .frame(maxWidth: .infinity)
                }
                .tint(Color("brandGreen"))
                .foregroundStyle(.white)
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            // MARK: Logout button
            Button {
                UserDefaults.standard.setValue(false, forKey: kLoggedIn)
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Logout")
                    .frame(maxWidth: .infinity)
            }
            .tint(Color("brandYellow"))
            .foregroundStyle(.black)
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    UserProfile()
}
