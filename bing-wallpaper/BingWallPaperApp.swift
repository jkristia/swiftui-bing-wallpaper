import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    // https://stackoverflow.com/questions/65460457/how-do-i-disable-the-show-tab-bar-menu-option-in-swiftui
    func applicationDidFinishLaunching(_ notification: Notification) {
//        print("Info from `applicationDidFinishLaunching(_:): Finished launching…")
        //        let _ = NSApplication.shared.windows.map { $0.tabbingMode = .disallowed }
        NSWindow.allowsAutomaticWindowTabbing = false
    }
}

@main
struct BingWallPaperApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

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
