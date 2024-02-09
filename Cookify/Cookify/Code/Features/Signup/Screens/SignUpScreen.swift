import SwiftUI

struct SignUpScreen: View {
    
    // login view model holds email, password, and login actions
    @ObservedObject var viewModel: SignUpViewModel = SignUpViewModel()
    
    // to go back to sign in
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack { // for background color
            Color(red: 0.996, green: 0.961, blue: 0.929)
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                // bread image
                Image("bread_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 30)
                                
                Text("enter your email address")
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.gray)

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
                .foregroundColor(.gray)
                
                Text("enter your password")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)

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
                .foregroundColor(.gray)
                
                Text("confirm your password")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)

                // password input field
                SecureField(
                    "password",
                    text: $viewModel.confirmPassword
                )
                .padding(15)
                .font(.system(size: 20))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 1)
                )
                .foregroundColor(.gray)
                
                
                // signup button
                Button(
                    action: viewModel.signup,
                    label: {
                        Text("sign up")
                            .font(.system(size: 30))
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .foregroundColor(Color(red: 0.6, green: 0.655, blue: 0.6))
                            .underline()
                    }
                )
                
                Spacer()
                
                // back to sign up button
                Text("back to login")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .foregroundColor(Color(red: 0.6, green: 0.655, blue: 0.6))
                    .underline()
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                
            }.navigationBarBackButtonHidden(true)
            .padding(30) // padding around all elements
            
        }.onTapGesture {
            self.hideKeyboard()
        }
    }
}

#Preview {
    SignUpScreen()
}
