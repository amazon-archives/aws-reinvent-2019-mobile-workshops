/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual landmark.
*/

import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
    
    var id: String
    var name: String
    var imageName: String
    fileprivate var coordinates: Coordinates
    var state: String
    var park: String
    var category: Category
    var isFavorite: Bool

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    enum Category: String, CaseIterable, Codable, Hashable {
        case featured = "Featured"
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
}

// this synchronously load the images.
// TODO return a generic image while the correct one is loading
// this method is called each time the UI needs to draw the image.
// TODO Use a cache instead of downloading everytime
extension Landmark {
    var image: Image {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.image(self)
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
