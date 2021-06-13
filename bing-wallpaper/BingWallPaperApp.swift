import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    // https://stackoverflow.com/questions/65460457/how-do-i-disable-the-show-tab-bar-menu-option-in-swiftui
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
        // Remove default 'Edit' menu from main menu
        if let mainMenu = NSApp .mainMenu {
            DispatchQueue.main.async {
                if let edit = mainMenu.items.first(where: { $0.title == "Edit"}) {
                    mainMenu.removeItem(edit);
                }
            }
        }
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
