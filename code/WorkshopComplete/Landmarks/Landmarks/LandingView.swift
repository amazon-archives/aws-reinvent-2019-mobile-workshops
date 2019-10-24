//
//  LandingView.swift
//  Landmarks
//
//  Created by Stormacq, Sebastien on 23/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    @ObservedObject public var user : UserData
    
    var body: some View {
        
        let loginView = LoginViewController()

        return VStack {
            // .wrappedValue is used to extract the Bool from Binding<Bool> type
            if (!$user.isSignedIn.wrappedValue) {
                
                ZStack {
                    loginView
                    Button(action: { loginView.authenticate() } ) {
                        UserBadge().scaleEffect(0.5)
                    }
                }

            } else {
                LandmarkList().environmentObject(user)
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        let app = UIApplication.shared.delegate as! AppDelegate
        return LandingView(user: app.userData)
    }
}
