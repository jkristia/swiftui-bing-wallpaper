import SwiftUI

struct ImageLargeView: View {
    @EnvironmentObject var datastore: Datastore
    var selectedItem: ImageInfo?
    
    func noView() -> some View {
        return Text("Select an image")
    }
    
    @ViewBuilder
    var body: some View {
        let hasView = selectedItem != nil
        if hasView == false {
            noView()
        } else {
            let radius = CGFloat(8)
            let item = selectedItem!
            let imageInfo = item
            let hasLink = imageInfo.imageUrl != nil
            ZStack {
                VStack {
                    Spacer()
                    Text(item.meta!.title)
                        .font(.system(size: 20))
                    Text(item.meta!.copyright)
                        .font(.system(size: 12))
                        .opacity(0.4)
                    Image(nsImage: imageInfo.image != nil ? imageInfo.image! : NSImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(radius)
                        .overlay(RoundedRectangle(cornerRadius: radius)
                                    .stroke(Color(#colorLiteral(red: 0.7437103391, green: 0.7437103391, blue: 0.7437103391, alpha: 0.6982967688)), lineWidth: 4))
                        .padding(5)
                        .shadow(radius: 5, x: 5, y: 5)
                    Spacer()
                    HStack {
                        Spacer()
                        if hasLink {
                            LinkView(imageInfo: imageInfo)
                        }
                        Spacer()
                        Button("Save Image") {
                            self.saveImage(imageInfo)
                        }
                    }
                    .padding(.bottom, 10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(5)
        }
    }
    
    private func saveImage(_ info: ImageInfo) {
        let image: NSImage = info.image!
        let panel = NSSavePanel()
        let split: [String] = info.imageUrl!.components(separatedBy: "=") // split
        // last part of the uril is the filename
        let filename = split[split.count - 1]
        panel.title = "Save Image"
        panel.nameFieldStringValue = filename
        panel.canCreateDirectories = true
        panel.begin { response in
            if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
                print(fileUrl)
                let _ = image.pngWrite(to: fileUrl)
            }
        }
    }
}
