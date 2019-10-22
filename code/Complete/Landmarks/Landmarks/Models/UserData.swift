//
//  User.swift
//  Landmarks
//
//  Created by Stormacq, Sebastien on 24/09/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


final class UserData : ObservableObject {
    
    @Published var showFavoritesOnly = false
    @Published var landmarks : [Landmark] = []
    @Published var isSignedIn : Bool = false
}
