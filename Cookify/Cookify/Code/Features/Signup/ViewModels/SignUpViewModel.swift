import Foundation

class SignUpViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    
    func signup() {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else{
            print("Enter information in all fields")
            return
        }
        
        if(password != confirmPassword){
            print("Passwords must match")
            return
        }
        
        Task {
            do{
                let user = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("LOGGED IN SUCCESSFULLY")
                print(user)
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    
    
    
    
    
//    func signup() {
//        SignUpAction(
//            parameters: SignUpRequest(
//                email: email,
//                password: password
//            )
//        ).call { _ in
//            // Login successful, navigate to the Home screen
//        }
//    }
    
}
