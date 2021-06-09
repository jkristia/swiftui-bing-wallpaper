import Foundation
import SwiftUI

// https://stackoverflow.com/questions/39925248/swift-on-macos-how-to-save-nsimage-to-disk
extension NSImage {
    var pngData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        return bitmapImage.representation(using: .png, properties: [:])
    }
    func pngWrite(to url: URL) -> Bool {
        do {
            let options: Data.WritingOptions = .atomic
            try pngData?.write(to: url, options: options)
            return true
        } catch {
            print(error)
            return false
        }
    }
}

