//
//  ModalWeatherViewModel.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 14.11.22.
//

import Foundation

struct ModalWeatherViewModel {
    
    private var collectionViewItems: [ModalWeatherModel] = []

    mutating func appendCollections(items: ModalWeatherModel) {
        collectionViewItems.append(items)
    }
    
    func getNumberOfItemsInSection() -> Int {
        return collectionViewItems.count
    }
    
    func getModel(at index: Int) -> ModalWeatherModel {
        return collectionViewItems[index]
    }
    
    func getTempMax(model: APIResponseObject.List) -> String? {
        guard let unwrappedModel = model.main,
              let unwrappedTempMax = unwrappedModel.tempMax else { return nil }
        
        return "\(Int(unwrappedTempMax - 273.15))°C"
    }
    
    func getImageTemperatureName(model: APIResponseObject.List) -> String {
        guard let unwrappedModel = model.weather?.first,
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
    
    func getWeekDay(timeInterval: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let date = Date(timeIntervalSince1970: timeInterval)
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
}
