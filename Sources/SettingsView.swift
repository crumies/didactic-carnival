import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: AppSettings
    @EnvironmentObject var ble: DunenBLEManager

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Settings").font(.largeTitle.weight(.heavy))
                        Text("Aptum Dashboard").font(.caption).foregroundStyle(.cyan)
                    }
                    Spacer()
                    AptumLogoImage().frame(width: 52, height: 52).clipShape(RoundedRectangle(cornerRadius: 12))
                }

                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Speed Unit").font(.headline)
                        Picker("Speed", selection: Binding(get: { settings.speedUnit }, set: { settings.speedUnit = $0 })) {
                            ForEach(SpeedUnit.allCases) { unit in
                                Text(unit.rawValue).tag(unit)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }

                GlassCard {
                    VStack(spacing: 16) {
                        Toggle("Startup animation", isOn: $settings.startupAnimation).tint(.cyan)
                        Toggle("Show raw packet logger", isOn: $settings.showRawPackets).tint(.cyan)
                        Toggle("Tuning unlocked", isOn: $settings.expertTuningUnlocked).tint(.orange)
                    }
                }

                GlassCard {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Connection").font(.headline)
                        Text(ble.connectionStatus).font(.caption).foregroundStyle(.secondary)

                        HStack {
                            Button(ble.isScanning ? "Scanning..." : "Scan DUNEN") { ble.startScan() }
                                .buttonStyle(.borderedProminent)
                                .tint(.cyan)
                                .disabled(ble.isScanning)

                            Button("Disconnect") { ble.disconnect() }
                                .buttonStyle(.bordered)
                                .disabled(!ble.isConnected)
                        }

                        ForEach(ble.discoveredDevices) { device in
                            Button { ble.connect(to: device) } label: {
                                HStack {
                                    Text(device.name)
                                    Spacer()
                                    Text("\(device.rssi) dBm").foregroundStyle(.secondary)
                                }
                            }
                            .buttonStyle(.plain)
                            Divider().opacity(0.2)
                        }
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.top, 10)
            .padding(.bottom, 112)
        }
    }
}
