//
//  ListNetworking.swift
//  TestApp
//
//  Created by Константин Киски on 14.07.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import Foundation
import Alamofire

class ListNetworking {

    // MARK: - Init
    
    init() {}

    // MARK: - Functions
    
    /// Получаем список с параметрами
    /// - Returns: (MainData, NetworkManagerError), где MainData - список параметров, а NetworkManagerError - ошибка, если она есть
    func getList(completion: @escaping (MainData, NetworkManagerError?) -> Void) {
        let urlString = "https://pryaniky.com/static/json/sample.json"
        AF.request(urlString).response { response in
            
            guard let data = response.data else {
                completion(MainData(), NetworkManagerError(kind: .serverIsDown))
                return
            }
            do {

                let decoder = JSONDecoder()

                let mainData = try decoder.decode(MainData.self, from: data)

                completion(mainData, nil)
            } catch let error {
                completion(MainData(), error as? NetworkManagerError)
            }
        }
    }
}
