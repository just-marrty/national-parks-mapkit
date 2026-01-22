//
//  ParkViewModel+Extensions
//  NationalParks
//
//  Created by Martin Hrbáček on 19.01.2026.
//

import Foundation

extension ParkViewModel {
    static let sampleParkDetailView = ParkViewModel(
        park: Park(
            name: "Yellowstone National Park",
            state: ["Wyoming", "Montana", "Idaho"],
            parkAccess: "Always open",
            description: "The world’s first national park and one of the most geologically active regions on Earth. Yellowstone is renowned for its extraordinary concentration of geysers, including Old Faithful, as well as vividly colored hot springs, fumaroles, and mud pots driven by volcanic heat below the surface. Beyond geothermal wonders, the park encompasses vast forests, sweeping valleys, rivers, waterfalls, and broad plateaus. Yellowstone also protects one of the largest intact temperate ecosystems, offering exceptional wildlife viewing with bison, elk, wolves, bears, and many other species roaming freely.",
            weatherInfo: "Located at high elevation, Yellowstone experiences rapid and often unpredictable weather changes throughout the year. Winters are long and harsh, bringing heavy snowfall and prolonged cold that can persist into late spring. Summers are relatively short and mild, but sudden thunderstorms, sharp temperature drops, and even snowfall at higher elevations can occur. Visitors should be prepared for changing conditions in any season and plan for limited services during winter months.",
            longitude: -110.5885,
            latitude: 44.428,
            officialWebsite: "https://www.nps.gov/yell"
        )
    )
}
