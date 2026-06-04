# SD Beach Report

A native iOS app for checking real-time water quality and advisory status at beaches across San Diego County.

## Overview

SD Beach Report pulls live data from the San Diego County Department of Environmental Health and Quality (DEH) Beach and Bay Program and presents it in a clean, easy to read format. Quickly see which beaches are open, under advisory, or closed before you head out.

## Features

- **Live beach status** — fetches current water quality reports from the DEH on launch with pull to refresh
- **Status indicators** — beaches are color coded by status (Closed, Advisory, Open) with clear iconography
- **Favorites** — swipe right on any beach to favorite it, with persistent storage and drag to reorder
- **Detail view** — tap any beach to see full description, advisory, and closure information with HTML rendered properly
- **Full beach list** — searchable and sortable list of all monitored San Diego beaches
- **Interactive map** — all beach locations plotted on a map with color coded pins, tap a pin or select from the sheet list to view details

## Data Source

Beach water quality data is sourced from the San Diego County DEH Beach and Bay Program. All monitoring data, sampling results, and water quality assessments are their work — this app simply presents it in a convenient format.

## Requirements

- iOS 26+
- Xcode 26+
- Internet connection for live data

## Installation

1. Clone the repository
```bash
git clone https://github.com/brysonreese/SD-Beach-Report.git
```
2. Open `SDBeachReport.xcodeproj` in Xcode
3. Select your target device or simulator
4. Build and run (`Cmd + R`)

No third party dependencies — the project uses only native Swift, SwiftUI, and MapKit frameworks.

## Project Structure

```
SD Beach Report
├── Components
│   ├── BeachList.swift
│   ├── BeachMapPin.swift
│   └── BeachReportRow.swift
├── Extensions
│   └── String+Extensions.swift
├── Models
│   └── BeachReport.swift
├── Repositories
│   └── BeachReportRepository.swift
├── Views
│   ├── AboutInfoView.swift
│   ├── DetailsView.swift
│   ├── FullListView.swift
│   ├── MainView.swift
│   ├── MapView.swift
├── Assets.xcassets
├── SDBeachReportApp.swift
└── README.md
```

## Contributing

Contributions are welcome. Feel free to open an issue or submit a pull request.

## License

© Bryson Reese 2026. All rights reserved.

---

Built by [Bryson Reese](https://brysonreese.com)
