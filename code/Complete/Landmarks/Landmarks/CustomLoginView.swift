import SwiftUI

struct CustomLoginView : View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    private let app = UIApplication.shared.delegate as! AppDelegate

    var body: some View { // The body of the screen view
        VStack {
            Image("turtlerock")
            .resizable()
            .aspectRatio(contentMode: ContentMode.fit)
            .padding(Edge.Set.bottom, 20)
            
            Text(verbatim: "Login").bold().font(.title)
            
            Text(verbatim: "Explore Landmarks of the world")
            .font(.subheadline)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 70, trailing: 0))
                                
            TextField("Username", text: $username)
            .autocapitalization(.none) //avoid autocapitalization of the first letter
            .padding()
            .cornerRadius(4.0)
            .background(Color(UIColor.systemFill))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
            
            SecureField("Password", text: $password)
            .padding()
            .cornerRadius(4.0)
            .background(Color(UIColor.systemFill))
            .padding(.bottom, 10)

            Button(action: { self.app.signIn(username: self.username, password: self.password) }) {
                HStack() {
                    Spacer()
                    Text("Signin")
                        .foregroundColor(Color.white)
                        .bold()
                    Spacer()
                }
                                
            }.padding().background(Color.green).cornerRadius(4.0)
        }.padding()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
static var previews: some View {
        CustomLoginView() // Renders your UI View on the XCode preview
    }
}
#endif
