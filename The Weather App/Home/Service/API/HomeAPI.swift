//
//  HomeAPI.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 13.11.22.
//

import Foundation
import Alamofire

struct HomeAPI {
   
    @discardableResult
    static func getHomeContent(
        alamofireParametersConvertible: AlamofireParametersConvertible,
        otherHeaders: HTTPHeaders,
        queue: DispatchQueue? = nil,
        _ complation: @escaping (DataResponse<Data>, Swift.Result<APIResponseObject.WeatherDataResponse, Error>) -> Void
    ) -> DataRequest {
        
        let sessionManager = SessionManager.default
        let request = sessionManager.request(HomeAPIRouter.getWeatherData(
            alamofireParametersConvertible: alamofireParametersConvertible,
            otherHeaders: otherHeaders
        ))
        
        request.responseData(queue: queue) { response in
            switch response.result {
            case .failure(let error):
                complation(response, .failure(error))
                
            case .success(let data):
                do {
                    complation(response, .success(try JSONDecoder().decode(APIResponseObject.WeatherDataResponse.self, from: data)))
                } catch {
                    complation(response, .failure(error))
                }
            }
        }
        
        return request
    }

}
