//
//  DataProvider.swift
//  culturetrip
//
//  Created by Yael Bilu Eran on 06/11/2020.
//

import Foundation

public class DataProvider :APIClient {
    let session: URLSession
    public static let shared = DataProvider()
    private let apiUrl = "https://cdn.theculturetrip.com/home-assignment/response.json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd mmm, yyyy"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func fetchData(completion: @escaping (Result<[Article]?, APIError>) -> Void) {
        guard let urlApiPath = apiUrl, let url = URL(string: urlApiPath) else {
            return
        }
        fetch(with: url , decode: { json -> DataResponse? in
            guard let result = json as? DataResponse else { return  nil }
            return result
        }, completion: {result  in
            switch result{
            case .success(let dataResponse):
                completion(Result.success(dataResponse.data))
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }
}

    
    
    
    
    
   
    

