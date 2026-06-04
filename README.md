# SD Beach Report

An iOS app for checking water quality and advisory status for beaches across San Diego County.

## Overview

SD Beach Report pulls live data from the San Diego County Department of Environmental Health (DEH) beach monitoring API and displays current water quality status for beaches across the county. Users can quickly see which beaches are open, under advisory, or closed, and save their favorite spots for quick access.

## Features

- **Live beach status** — fetches current water quality reports from the DEH API on launch
- **Status indicators** — beaches are color coded and iconified by status (Closed, Advisory, Open)
- **Sorted by urgency** — closures appear first, followed by advisories, then open beaches
- **Favorites** — swipe to favorite any beach, persisted between app launches via UserDefaults
- **Detail view** — tap any beach to see full description, advisory, and closure information

## Data Source

Beach water quality data is sourced from the San Diego County DEH live water quality JSON feed. Data includes site identifiers, indicator status, descriptions, and any active advisories or closures.

## Requirements

- iOS 16+
- Xcode 15+
- Internet connection for live data

## Installation

1. Clone the repository
2. Open `BeachApp.xcodeproj` in Xcode
3. Select your target device or simulator
4. Build and run (`Cmd + R`)

No third party dependencies — the project uses only native Swift and SwiftUI frameworks.
