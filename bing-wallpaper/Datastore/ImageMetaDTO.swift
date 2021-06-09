import Foundation
import SwiftUI
import Cocoa

// Classes matching json returned from Bing request

struct ImageMetaDTO : Codable {
    var url: String
    var urlbase: String
    var title: String
    var copyright: String
    
    // json - How to exclude properties from Swift 4's Codable - Stack Overflow
    // https://stackoverflow.com/questions/44655562/how-to-exclude-properties-from-swift-4s-codable
    private enum CodingKeys: String, CodingKey {
            case url, urlbase, title, copyright
    }
}

struct ImagesMetaDTO : Codable{
    var images: [ImageMetaDTO]
}
