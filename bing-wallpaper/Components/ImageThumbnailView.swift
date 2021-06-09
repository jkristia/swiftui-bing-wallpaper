import SwiftUI
import Foundation
import Cocoa

struct ImageThumbnailView: View {
    @ObservedObject var imageInfo: ImageInfo
    @State private var hover = false
    
    var width: CGFloat = 100
    var height: CGFloat = 100
    
    var body: some View {
        return
            HStack {
                Image(nsImage: imageInfo.thumbnail != nil ? imageInfo.thumbnail! : NSImage())
                    .resizable()
                    .frame(width: width, height: height, alignment: .leading)
                    .cornerRadius(5)
            }
            .padding(5)
            .background(hover ? Color.blue : Color.clear)
            .onHover() { hover in
                self.hover = hover
            }
    }
}
