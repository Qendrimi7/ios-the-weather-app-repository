//
//  HomeViewModel.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import Foundation
import UIKit

struct HomeViewModel {
    
    var sections: [APIResponseObject.WeatherDataResponse] = []
    private var currentPage = 1
    private var numberOfMoviesInCollectionForPage: Int = 20
    
    mutating func appendSections(response: [APIResponseObject.WeatherDataResponse]) {
        if sections.isEmpty {
            sections = response
        } else {
            sections.append(contentsOf: response)
        }
    }
    
    func sectionsCount() -> Int {
        return sections.count
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func section(at index: Int) -> APIResponseObject.WeatherDataResponse {
        return sections[index]
    }

    func isSectionEmpty() -> Bool {
        return sections.isEmpty
    }
    
    func getTempMax(model: APIResponseObject.WeatherDataResponse) -> String? {
        guard let unwrappedFirstItem = model.list?.first,
              let unwrappedModel = unwrappedFirstItem.main,
              let unwrappedTempMax = unwrappedModel.tempMax else { return nil }
        
        return "\(Int(unwrappedTempMax - 273.15))°C"
    }
    
    func getImageTemperatureName(model: APIResponseObject.WeatherDataResponse) -> String {
        guard let unwrappedFirstItem = model.list?.first,
              let unwrappedModel = unwrappedFirstItem.weather?.first,
              let unwrappedID = unwrappedModel.id else { return "default_icone" }
        
        switch unwrappedID {
        case 804:
            //overcast clouds
            return "cloudy"
        case 803:
            //broken clouds
            return "cloudy"
        case 802:
            //scattered clouds
            return "partly_cloudy"
        case 801:
            //few clouds
            return "partly_cloudy"
        case 800:
            //clear sky
            return "sunny"
        default:
            return "default_icone"
            
        }
    }
    
    func getDayName(model: APIResponseObject.WeatherDataResponse) -> String? {
        guard let unwrappedFirstItem = model.list?.first else { return nil }
        let date = Date(timeIntervalSince1970: unwrappedFirstItem.dt)
        let calendar = Calendar.current
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        
        if calendar.isDateInToday(date) { return "Today" }
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        
        let startOfNow = calendar.startOfDay(for: Date())
        let startOfTimeStamp = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
        if let unwrappedDay = components.day {
            if unwrappedDay < 1 {
                return "\(-unwrappedDay) days ago"
                
            } else {
                return "In \(unwrappedDay) days"
            }
        }
        
        return nil
    }
    
    func getCountryNameOrCity(model: APIResponseObject.WeatherDataResponse) -> String? {
        guard let unwrappedCity = model.city else { return nil }
        return unwrappedCity.name
    }
}
