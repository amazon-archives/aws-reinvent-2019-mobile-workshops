/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Helpers for loading images and data.
*/

import UIKit
import SwiftUI
import CoreLocation

// this is just used for the previews. At runtime, data are now taken from UserData and loaded through AppDelegate
let landmarkData: [Landmark] = load("landmarkData.json")

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

final class ImageStore {
    
    // a cache for my images
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    static var shared = ImageStore()
    
    init() {
        // create a placeholder image at initialization time
        guard
            let url = Bundle.main.url(forResource: "white", withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image white.jpg from main bundle.")
        }
        
        // and cache it
        images["placeholder"] = image
    }
    
    // return the placeholder
    func placeholder() -> Image {
        return self.image(name: "placeholder", landmark: nil)
    }
    
    // return the image
    func image(name: String, landmark : Landmark?) -> Image {
        
        // first check if CGImage is in the cache, return the image when it is in the cache
        if let index = images.index(forKey: name) {
            
            // create an image from CGImage at the correct size
            let image =  Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(verbatim: name))
    
            // set the landmark image
            // this will trigger the update of the View (hence switching to GUI thread)
            DispatchQueue.main.async() {
                if let l = landmark {
                    l.image = image
                }
            }
            
            return image

        } else {
        
            // asynchronously load image, pass a callback to be notified when loaded
            let app = UIApplication.shared.delegate as! AppDelegate
            app.image(name, dataAvailable: { (data) -> Void in
                
                // image is loaded, store it in the cache
                self.images[name] = UIImage(data: data)?.cgImage
                
                // recursive call to trigger an update on Landmark object
                let _ = self.image(name: name, landmark: landmark)
                
            })
        
            // return any image, it will not be used.
            return self.placeholder()
        }
    }
}

