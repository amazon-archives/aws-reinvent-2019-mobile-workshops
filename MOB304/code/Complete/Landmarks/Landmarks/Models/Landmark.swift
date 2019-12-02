/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual landmark.
*/

import SwiftUI
import CoreLocation

// migrated Landmark from struct to class to make it Observable
class Landmark: Decodable, Identifiable, ObservableObject {
    
    // consequence is that I need to add the constructor
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LandmarkKeys.self) // defining our (keyed) container
        id          = try container.decode(Int.self, forKey: .id)
        name        = try container.decode(String.self, forKey: .name)
        imageName   = try container.decode(String.self, forKey: .imageName)
        state       = try container.decode(String.self, forKey: .state)
        park        = try container.decode(String.self, forKey: .park)
        isFavorite  = try container.decode(Bool.self, forKey: .isFavorite)
        category    = try container.decode(Category.self, forKey: .category)
        coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        
        // set a place holder image
        image = ImageStore.shared.placeholder()
        
        // trigger image download
        let _ = ImageStore.shared.image(name: imageName, landmark: self)
    }
    
    var id: Int
    var name: String
    fileprivate var imageName: String
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
    
    // advertise changes on this property.  This will allow Views to refresh when image is changed.
    @Published var image : Image
    
    // part of Decodable protocol, I need to declare all keys from the jSON file
    enum LandmarkKeys: String, CodingKey {
        case id          = "id"
        case name        = "name"
        case imageName   = "imageName"
        case category    = "category"
        case isFavorite  = "isFavorite"
        case park        = "park"
        case state       = "state"
        case coordinates = "coordinates"
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
