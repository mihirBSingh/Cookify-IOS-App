import Foundation

//make a codable struct to get data from json THEN populate env. obj


@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
        
    
    func signup() async throws {
//        guard !email.isEmpty, !password.isEmpty else{
//            print("NO EMAIL OR PASSWORD ENTERED")
//            return
//        }
        
        //first create new user IN AUTH
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        
        //INIT a user model after creating auth - empty posts, following and followers
        let user = DBUser(auth: authDataResult)
        
        //then push user object IN FIRESTORE based on Id
        try await UserManager.shared.createNewUser(user: user)
        
    }
    
    func login() async throws {
//        guard !email.isEmpty, !password.isEmpty else{
//            print("NO EMAIL OR PASSWORD ENTERED")
//            return
//        }
        
        //first log in with AUTH
        try await AuthenticationManager.shared.signInExistingUser(email: email, password: password)
        
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
//    
//    
//    
//    //when user hits login button, populates environment object
//    func loginOLD(with accountObject: AccountObject){
//        
//        var accountList = [AccountModel]()
//        print(email)
//        print(password)
//        
//        //GET data of "Data" type from JSON
//        let data = getJSON().convertJSON(forName: "USERS")
//
//        
//        //CONVERT DATA TO LIST OF ACCOUNT STRUCTS
//        do{
//            accountList = try JSONDecoder().decode([AccountModel].self, from: data)
//            print("success")
//            print(accountList)
//        } catch {
//            print("Can't make list of accounts")
//        }
//        
//        
//        var emailExists = false
//        
//        //CHECK IF LOGGED IN CORRECTLY
//        for acct in accountList{
//            
//            //IF USERNAME MATCH
//            if(acct.email == email){
//                
//                //IF CORRECT PASSWORD, POPULATE ACCOUNT ENV. OBJ AND NAVIGATE
//                if(password == acct.password){
//                    print("Logged in successfully!")
//                    //still need to navigate - wrap button in loginscreen with ternary operator?
//                    
//                    //populate accounntObject
//                    accountObject.populate(with: acct)
//                }
//                else{
//                    print("Password incorrect. Try again")
//                }
//                emailExists = true
//                break
//            }
//        }
//        //IF CAN'T FIND EMAIL, THROW ERROR
//        if(!emailExists) {print("Email/user not found")}
//    }
//}
//
//
//    
    
    
    //FOR NOW, WE ARE USING JSON, not LOGINREQUEST ACTION
//
//    func login() {
//        LoginAction(
//            parameters: LoginRequest(
//                email: email,
//                password: password
//            )
//        ).call { _ in
//            // Login successful, navigate to the Home screen
//        }
//    }
    

