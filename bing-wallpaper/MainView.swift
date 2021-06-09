import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: Datastore
    
    var body: some View {
        VStack {
            ImageThumbnailListView()
                .frame(height: 100)

            VStack {
                ImageLargeView(selectedItem: store.selectedItem)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: .infinity)
            .background(Color.yellow.opacity(0.02))
        }
        .padding(5)
        .padding(.top, 10)
        .frame(minWidth: 975, maxWidth: .infinity, minHeight: 800, maxHeight: .infinity, alignment: .center)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

