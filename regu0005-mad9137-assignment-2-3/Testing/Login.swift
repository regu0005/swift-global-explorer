//
//  Login.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-14.
//

import SwiftUI
//import Firebase
//import ToastUI

struct Login: View {
    
    @State var email = ""
    @State var password = ""
    @State var userIsLoggedIn = false
    
    @State var presentingToast: Bool = false
    
    var body: some View {
//        if(userIsLoggedIn) {
//            // show new view
//            ListView()
//        }
//        else
//        {
//            //content
//        }
        
        
        VStack {
                    Spacer()

                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .padding(.bottom, 50)

                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)

                    Button(action: login) {

                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                    }
                    
//                    .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
//                          ToastView("Loading...")
//                            .toastViewStyle(.indeterminate)
//                        }
                    Button(action: signup) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                    }
                    

                    Spacer()

                    HStack {
                        Text("Forgot Password?")
                            .foregroundColor(.blue)
                    }.padding()
                }
                .padding()
    }
   
    func login(){
        presentingToast = true
//        Auth.auth().signIn(withEmail: email, password: password) {
//            result, error in
//            if(error != nil) {
//                print(error?.localizedDescription ?? "")
//            }
//            else
//            {
//                print("Sign in successful")
//            }
//        }
    }
    
    func signup(){
        print("Sign Up")
//        Auth.auth().createUser(withEmail: email, password: password)
//        {
//            result, error in
//            if(error != nil) {
//                print(error?.localizedDescription ?? "")
//            }
//            else
//            {
//                print("Sign up successful")
//            }
//        }
    }
}

#Preview {
    Login()
}
