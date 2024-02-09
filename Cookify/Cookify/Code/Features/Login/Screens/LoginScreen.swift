import SwiftUI

// function to hide keyboard on tap anywhere on screen
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoginScreen: View {
    
    // login view model holds email, password, and login actions
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    @Binding var showLoginView: Bool
    
    var body: some View {
        
        NavigationView {
            
            ZStack { // for background color
                Color(red: 0.996, green: 0.961, blue: 0.929)
                    .ignoresSafeArea()
                
                VStack(spacing: 15) {
                    
                    // cookify title
                    Text("Cookify")
                        .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                        .font(.system(size: 85))
                        .italic()
                    
                    // bread image
                    Image("bread_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 30)
                    
                    // email input field
                    TextField(
                        "email",
                        text: $viewModel.email
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(15)
                    .font(.system(size: 20))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1)
                    )
                    
                    // password input field
                    SecureField(
                        "password",
                        text: $viewModel.password
                    )
                    .padding(15)
                    .font(.system(size: 20))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1)
                    )
                    
                    // login button
                    HStack(spacing: 20) {
                        Button{
                            //LOGIN USING FIREBASE AUTH - in Authentication/AuthenticationManager
                            Task {
                                do {
                                    try await viewModel.signup()
                                    print("SIGN UP")
                                    showLoginView = false
                                } catch {
                                    print("ERROR: \(error)")
                                }
                                
                                do {
                                    try await viewModel.login()
                                    print("LOG IN")
                                    showLoginView = false
                                } catch {
                                    print("ERROR: \(error)")
                                }
                            }

                        } label: {
                                Text("login / sign up")
                                    .font(.system(size: 30))
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .foregroundColor(Color(red: 0.6, green: 0.655, blue: 0.6))
                                    .underline()
                        }
                        
                        
//                        // OLD SIGN UP BUTTON
//                        NavigationLink(destination: SignUpScreen()) {
//                            Text("sign up")
//                                .font(.system(size: 30))
//                                .frame(maxWidth: .infinity, maxHeight: 60)
//                                .foregroundColor(Color(red: 0.6, green: 0.655, blue: 0.6))
//                                .underline()
//                        }
                    }
                    
                }.padding(30) // padding around all elements
            }.onTapGesture {
                self.hideKeyboard()
            }
            .transition(/*@START_MENU_TOKEN@*/.opacity/*@END_MENU_TOKEN@*/)
        }
    }
}
        

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(showLoginView: .constant(false))
    }
}
