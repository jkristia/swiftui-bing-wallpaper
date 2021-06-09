import SwiftUI

struct LinkView: View {
    @State private var hover: Bool = false
    var imageInfo: ImageInfo
    var body: some View {
        Text(imageInfo.imageUrl != nil ? imageInfo.imageUrl! : "Missing Image URL")
            .padding(5)
            .foregroundColor( hover ? Color.blue.opacity(0.8) : Color(.labelColor).opacity(0.8))
            .onTapGesture {
                onUrlClick(url: imageInfo.imageUrl!)
            }
            .onHover { hover in
                self.hover = hover
                DispatchQueue.main.async {
                    hover ? NSCursor.pointingHand.push() : NSCursor.pop()
                }
            }
    }
    func onUrlClick(url: String) {
        guard let url = URL(string: url) else { return }
        NSWorkspace.shared.open(url)
    }
}

