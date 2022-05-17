//
//  Countries.swift
//  MAP523_FinalAssignment
//
//  Created by Newman Law on 2022-04-19.
//

import Foundation

struct Countries:Codable {
    
    
    var countryName:String = " "
    var capitalName:String = " "
    var countryCode:String = " "
    var population:Int = 0
    
    // - create a mapping between your properties and the
    // actual name of the key in the API response
    enum CodingKeys: String, CodingKey {
        case countryName="name"
        case capitalName="capital"
        case countryCode="alpha3Code"
        case population="population"
    }

    // implementation of the encode() --> Codable protocol
    func encode(to encoder:Encoder) throws {
          // do nothing
    }

    // custom init() --> parameter of type Decoder
    // Data comes back from the API
    // Decoder function will extract the information from the API and map it to the correct properties in the struct
    init(from decoder:Decoder) throws {
        // 1. try to take the api response and convert it to data we can use
        let response = try decoder.container(keyedBy: CodingKeys.self)

        // 2. extract the relevant keys from that api response
        self.countryName = try response.decodeIfPresent(String.self, forKey: .countryName) ?? " "
        self.capitalName = try response.decodeIfPresent(String.self, forKey: .capitalName) ?? " "
        self.countryCode = try response.decodeIfPresent(String.self, forKey: .countryCode) ?? " "
        self.population = try response.decodeIfPresent(Int.self, forKey: .population) ?? 0
        
    }
}
