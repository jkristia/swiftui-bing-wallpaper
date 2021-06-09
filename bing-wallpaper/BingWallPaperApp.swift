import SwiftUI

@main
struct BingWallPaperApp: App {

    let datastore = Datastore()

    init() {
        datastore.load()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .frame(minWidth: 975, maxWidth: .infinity, minHeight: 800, maxHeight: .infinity, alignment: .center)
                .environmentObject(datastore)
        }
    }
}
