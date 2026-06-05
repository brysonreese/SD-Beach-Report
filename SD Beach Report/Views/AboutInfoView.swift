import SwiftUI

struct AboutInfoView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = true
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("SD Beach Report")
                        .font(.headline)
                    Text("A simple app for checking water quality at San Diego beaches.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }
            
            Section("Data Source") {
                Text("Beach water quality data is provided by the San Diego County Department of Environmental Health and Quality (DEH) Beach and Bay Program.")
                
                Link("Visit DEH Beach & Bay Program",
                     destination: URL(string: "https://www.sandiegocounty.gov/deh/water/beach_bay.html")!)
            }
            
            Section("Disclaimer") {
                Text("SD Beach Report is an independent app and is not affiliated with, endorsed by, or officially connected to San Diego County or the Department of Environmental Health and Quality.")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                
                Text("Water quality data is fetched directly from the DEH and may not always reflect current conditions. Always exercise caution when swimming and follow all posted advisories and closures.")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            
            Section("Credits") {
                Text("All beach monitoring data, sampling results, and water quality assessments are the work of the San Diego County DEH Beach and Bay Program. This app simply presents their data in a convenient format.")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            
            Section("Open Source") {
                Text("SD Beach Report is open source. Contributions and feedback are welcome.")
                
                Link("View Source on GitHub",
                     destination: URL(string: "https://github.com/brysonreese/SD-Beach-Report")!)
                
                Link("brysonreese.com",
                     destination: URL(string: "https://brysonreese.com")!)
            }
            
            Section("Need a refresher?") {
                Button {
                    hasSeenOnboarding = false
                } label: {
                    Label("Show Onboarding Again", systemImage: "arrow.trianglehead.counterclockwise")
                }
            }
            
            Section {
                Text("© Bryson Reese \(String(Calendar.current.component(.year, from: Date()))). All rights reserved.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .listRowBackground(Color.clear)
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}
