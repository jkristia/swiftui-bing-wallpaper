import Foundation
import Cocoa

class ImageInfo : Identifiable, ObservableObject {
    let id = UUID()
    @Published var meta: ImageMetaDTO? = nil
    @Published var thumbnail: NSImage? = nil
    @Published var image: NSImage? = nil
    var imageUrl: String? = nil
}
