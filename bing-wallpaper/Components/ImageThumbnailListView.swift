import SwiftUI

struct ImageThumbnailListView: View {
    @EnvironmentObject var datastore: Datastore

    var body: some View {
        HStack {
            ForEach(datastore.items, id: \.id) { item in
                ImageThumbnailView(imageInfo: item)
                    .onTapGesture {
                        self.datastore.selectedItem = item;
                    }
            }
        }
        .padding(5)
    }
}
