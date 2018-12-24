//
//  APIManager.swift
//  GeoZillaTestAssigment
//
//  Created by Anton Stremovskiy on 12/23/18.
//  Copyright © 2018 áSoft. All rights reserved.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    var decoder = JSONDecoder()
    
    func createRequest<T: Decodable>(with request: RequestType, completion:((T) -> Void)? = nil) {
        if let path = Bundle.main.path(forResource: request.rawValue, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion?(try self.decoder.decode(T.self, from: data))
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
