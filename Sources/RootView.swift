import SwiftUI

struct RootView: View {
    @EnvironmentObject var ble: DunenBLEManager
    @EnvironmentObject var settings: AppSettings

    @State private var selectedTab: AppTab = .dashboard
    @State private var showSplash = true

    var body: some View {
        ZStack {
            AppBackground()

            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case .dashboard: DashboardView()
                    case .advanced: AdvancedInfoView()
                    case .tuning: TuningView()
                    case .diagnostics: DiagnosticsView()
                    case .settings: SettingsView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                LiquidTabBar(selectedTab: $selectedTab)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 8)
            }

            if showSplash && settings.startupAnimation {
                StartupSplash()
                    .transition(.opacity)
                    .zIndex(10)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                withAnimation(.easeInOut(duration: 0.35)) {
                    showSplash = false
                }
            }
        }
    }
}
