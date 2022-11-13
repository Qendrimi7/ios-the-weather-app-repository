//
//  HomeAPIRouter.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 13.11.22.
//

import Foundation
import Alamofire

enum HomeAPIRouter: URLRequestConvertible {

    case getWeatherData(
        alamofireParametersConvertible: AlamofireParametersConvertible,
        otherHeaders: HTTPHeaders
    )
    
    var method: HTTPMethod {
        switch self {
        case .getWeatherData:
            return .get
        }
    }
    
    var url: URL {
        switch self {
        case .getWeatherData(
            alamofireParametersConvertible: _,
            otherHeaders: _
        ):
            return Environment[.API_BASE_URL].appendingPathComponent("weather")
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getWeatherData(
                 alamofireParametersConvertible: _,
                 otherHeaders: let otherHeaders
             ):
            
            return otherHeaders
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .getWeatherData(
                  alamofireParametersConvertible: let alamofireParametersConvertible,
                  otherHeaders: _
              ):
            
            return alamofireParametersConvertible.alamofireParameters
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
            
        default:
            return JSONEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(
            url: url,
            method: method
        )
        urlRequest.allHTTPHeaderFields = headers
        
        return try encoding.encode(
            urlRequest,
            with: parameters
        )
    }
    
}
