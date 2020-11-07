//
//  DataResponse.swift
//  culturetrip
//
//  Created by Yael Bilu Eran on 06/11/2020.
//

import Foundation

struct DataResponse : Codable {
    let data : [Article]?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Article].self, forKey: .data)
    }

}
