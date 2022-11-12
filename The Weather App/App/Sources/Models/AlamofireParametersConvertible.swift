//
//  AlamofireParametersConvertible.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import Alamofire

protocol AlamofireParametersConvertible where Self: Encodable {
    var alamofireParameters: Parameters { get }
}

extension AlamofireParametersConvertible {
    var alamofireParameters: Parameters {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        guard let data = try? encoder.encode(self),
              let parameters = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return Parameters()
        }

        return parameters
    }
}
