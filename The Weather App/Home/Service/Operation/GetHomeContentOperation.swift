//
//  GetHomeContentOperation.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 13.11.22.
//

import Foundation
import Alamofire

class GetHomeContentOperation: Operation {
    
    private(set) var result: Swift.Result<APIResponseObject.WeatherDataResponse, Error>?
    
    private var apiRequestObject: APIRequestObject.GetWeatherData
    
    init(apiRequestObject: APIRequestObject.GetWeatherData) {
        self.apiRequestObject = apiRequestObject
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        Task {
            let getHomeContent = await getHomeContent(
                alamofireParametersConvertible: apiRequestObject,
                otherHeaders: [:]
            )
                        
            if isCancelled {
                return
            }
        
            result = getHomeContent
        }
        
    }
    
    private func getHomeContent(
        alamofireParametersConvertible: AlamofireParametersConvertible,
        otherHeaders: HTTPHeaders
    ) async -> Swift.Result<APIResponseObject.WeatherDataResponse, Error>? {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                HomeAPI.getHomeContent(
                    alamofireParametersConvertible: alamofireParametersConvertible,
                    otherHeaders: otherHeaders
                ) { (dataResponse, result) in
                    switch result {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                        
                    case .success(let responseModel):
                        continuation.resume(returning: .success(responseModel))
                    }
                }
            }
            
        } catch {
            return .failure(error)
        }
    }
    
}
