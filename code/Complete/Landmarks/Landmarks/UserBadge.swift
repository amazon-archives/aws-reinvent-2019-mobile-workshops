//
//  UserBadge.swift
//  Landmarks

import SwiftUI

struct UserBadge: View {
    var body: some View {
        GeometryReader { geometry in
        ZStack {
            Circle().stroke(Color.blue, lineWidth: geometry.size.width/50.0)

            VStack {
                Circle()
                    .frame(width:geometry.size.width / 2.0, height:geometry.size.width / 2.0, alignment: .center)
                    .foregroundColor(.blue)
                    .offset(x:0, y:geometry.size.width/3.3)

                Circle()
                    .frame(width:geometry.size.width, height:geometry.size.width, alignment: .center)
                    .foregroundColor(.blue)
                    .offset(x:0, y:geometry.size.width/3.0)

                
            }
        }
        .clipShape(Circle())
        .shadow(radius: geometry.size.width/30.0)
        }
    }
}

struct UserBadge_Previews: PreviewProvider {
    static var previews: some View {
        UserBadge()
    }
}
