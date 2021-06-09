import Foundation
import Cocoa

class Datastore : ObservableObject {
    private var _remote = RemoteAccess()

    @Published private(set) var items: [ImageInfo] = []
    @Published var selectedItem: ImageInfo? {
        didSet {
            guard let item = selectedItem else { return }
            loadImage(item: item)
        }
    }
    public func load() {
        _remote.getImageInfo { metaItems in
            self.items = []
            for metaItem in metaItems {
                let imageInfo = ImageInfo()
                imageInfo.meta = metaItem
                self.items.append(imageInfo)
            }
            
            for item in self.items {
                guard let meta = item.meta else { continue }
                self._remote.getThumbnail(imageMeta: meta) { result in
                    switch result {
                        case .success(let data ):
                            item.thumbnail = NSImage(data: data)
                            
                        case .failure(let error):
                            print("Error: \(error)")
                    }
                }
            }
        }
    }
    private func loadImage(item: ImageInfo) {
        guard let meta = item.meta else { return }
        if item.image == nil {
            self._remote.getImage(imageMeta: meta) { result in
                switch result {
                    case .success(let data ):
                        item.image = NSImage(data: data)
                        item.imageUrl = self._remote.getImageUrl(meta: meta)
                        // this to refrehs the full image view - not the correct way, but it works
                        self.objectWillChange.send()
                    case .failure(let error):
                        print("Error: \(error)")
                }
            }
        }
    }
}
