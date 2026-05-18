import SwiftUI

@main
struct AptumDashboardApp: App {
    @StateObject private var ble = DunenBLEManager()
    @StateObject private var tuning = TuningStore()
    @StateObject private var settings = AppSettings()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(ble)
                .environmentObject(tuning)
                .environmentObject(settings)
                .onAppear {
                    ble.attachTuningStore(tuning)
                    tuning.loadLocalBackup()
                }
        }
    }
}
