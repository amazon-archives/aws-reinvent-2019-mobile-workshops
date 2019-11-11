/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view showing a list of landmarks.
 */

import SwiftUI

struct SignOutButton : View {
    let app = UIApplication.shared.delegate as! AppDelegate

    var body: some View {
        NavigationLink(destination: LandingView(user: app.userData)) {
            Button(action: { self.app.signOut() }) {
                Text("Sign Out")
            }
        }
    }
}

struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData
        
    var body: some View {
        
        VStack {
            
            NavigationView {
                List {
                    
                    Toggle(isOn: $userData.showFavoritesOnly) {
                        Text("Show Favorites Only")
                    }
                    
                    ForEach(userData.landmarks) { landmark in
                        if !self.userData.showFavoritesOnly || landmark.isFavorite {
                            NavigationLink(
                                destination: LandmarkDetail(landmark: landmark)
                                    .environmentObject(self.userData)
                            ) {
                                LandmarkRow(landmark: landmark)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Landmarks"))
                .navigationBarItems(trailing: SignOutButton())
            }
        }
        
    }
}

struct LandmarksList_Previews: PreviewProvider {
    static let controller = UINavigationController()
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
    }
}
