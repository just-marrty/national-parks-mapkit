# National Parks

A SwiftUI application for browsing the top 20 most popular US National Parks with detailed information, interactive maps, and beautiful imagery. Built to showcase local JSON data loading, MapKit integration, and modern SwiftUI architecture patterns.

## Features

- Browse 20 national parks loaded from local JSON file
- Beautiful card-based grid layout with park images and state information
- Detailed park information including description, weather info, and park access
- Interactive maps with multiple map styles (standard, hybrid, imagery)
- Location annotations with animated tree symbols using SF Symbols
- Mini map preview in detail view with navigation to full-screen map
- Direct links to official National Park Service websites
- Smooth fade-in animations during loading
- Error handling with user-friendly messages and retry functionality
- Responsive UI with custom rounded typography
- Support for parks across multiple states

## Architecture

The project demonstrates modern SwiftUI patterns and MVVM architecture:

### Model

**Park** - Main data structure for national park information
- Properties: `id` (UUID), `name`, `state` (array), `parkAccess`, `description`, `weatherInfo`, `longitude`, `latitude`, `officialWebsite` (optional)
- Conforms to `Decodable`, `Identifiable`, and `Hashable`
- Computed property `image` - generates image asset name from park name (lowercased, spaces removed)
- Computed property `location` - converts lat/long to `CLLocationCoordinate2D`

### Constants

**Strings** - Centralized UI string constants

- Organizes all UI strings, error messages, and system image names
- Improves code maintainability and makes future localization easier
- Eliminates hardcoded strings throughout the codebase
- Used across all views and view models for consistent text display

**MapOptions** - Enum for map style selection
- Cases: `standard`, `hybrid`, `imagery`
- Computed property `mapStyle` - maps enum to MapKit's `MapStyle`

### Service

**FetchService** - Handles local JSON file loading
- Custom error handling with `FileError` enum (`invalidURL`, `decodingFail`)
- `fetchParks()` - Loads park data from `nationalparks.json` bundle resource
- Uses async/await pattern

### ViewModel

**ParkListViewModel** - Manages park list state and loading
- Uses `@Observable` macro for reactive UI updates
- `@MainActor` for thread-safe UI updates
- Dependency injection via initializer (receives `FetchService`)
- Properties: `parks`, `isLoading`, `errorMessage`
- Method: `loadParks()` - Loads parks from service and maps to view models

**ParkViewModel** - Presentation layer for single park
- Wraps `Park` model with computed properties
- Properties: `id`, `name`, `state`, `parkAccess`, `description`, `weatherInfo`, `longitude`, `latitude`, `image`, `location`, `officialWebsite`
- Conforms to `Identifiable` and `Hashable`
- Extension provides `sampleParkDetailView` for previews

### Views

**ParkMainView** - Main application view with park grid
- `NavigationStack` for navigation hierarchy
- Single-column `LazyVGrid` for park display
- Park cards with image, name, and state overlay
- Toolbar refresh button - reloads park data
- Error state with warning icon, message, and retry button
- Loading state with smooth fade-in animation
- Auto-load parks on view appearance using `.task`

**ParkDetailView** - Detailed park information view
- Full-width park image with gradient overlay
- Park name and state with shadow effects
- Clickable mini map preview (150x130pt) with animated tree annotation
- Description, weather info, park access, and official website sections
- Custom typography using rounded system font
- Navigation to full-screen `ParkMapView`

**ParkMapView** - Full-screen interactive map view
- Full-screen `Map` with camera position control
- Tree icon annotation at park location
- Map style picker at bottom (segmented control)
- Three map styles: Standard, Hybrid, Imagery

## Dependency Injection

The project uses constructor-based dependency injection:
- `ParkListViewModel` receives `FetchService` through initializer
- `ParkMainView` creates ViewModel with fresh `FetchService` instance
- Promotes loose coupling between views, view models, and services

## State Management

- `@State` for local view state (ViewModel instance, animation flags, map positions)
- `@Observable` macro for reactive ViewModel updates
- State-based animation control with boolean flags
- Loading animations with `withAnimation` and `.task`

## Data Structure

The app loads park information from `nationalparks.json` containing 20 parks:
- Yellowstone, Yosemite, Grand Canyon, Zion, Bryce Canyon, Arches
- Rocky Mountain, Grand Teton, Glacier, Acadia, Olympic, Sequoia
- Kings Canyon, Death Valley, Joshua Tree, Great Smoky Mountains
- Everglades, Denali, Hawaiʻi Volcanoes, Mount Rainier

Each park includes:
- Full name and state(s)
- Detailed description highlighting key features
- Weather information and seasonal conditions
- Park access information
- GPS coordinates for mapping
- Official NPS website link

## Technologies

- **SwiftUI** - Modern declarative UI framework
- **MapKit** - Native mapping with annotations and multiple styles
- **Async/Await** - Asynchronous file loading using modern Swift concurrency
- **NavigationStack** - Navigation hierarchy management
- **LazyVGrid** - Efficient grid layout with lazy loading
- **Observable** - Using `@Observable` macro for reactive UI updates
- **Dependency Injection** - Constructor-based DI for testability
- **JSON Decoding** - Custom Decodable implementation
- **Animation** - Smooth transitions with `withAnimation` and opacity
- **SF Symbols** - System icons for UI elements
- **Link** - Native web link handling

## Requirements

- iOS 26.0+
- Xcode 26.0+
- Swift 6+
