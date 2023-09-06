//
//  main.swift
//  RequestTest
//
//  Created by Marcos Abreu on 06/09/23.
//

import Foundation

struct Country: Codable {
    let countryID: String
    let countryName: String
    let countryLogo: String
    
    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case countryName = "country_name"
        case countryLogo = "country_logo"
    }
}

struct Countries: Decodable {
    let data: [Country]
}

func fetchRemoteCountries() async throws -> [Country] {
    let url = URL(string: "https://apiv3.apifootball.com/?action=get_countries&APIkey=fe56acd2acb45d94a9f1331149dc55aa2846896f38ecf1484de36d6a3cea87f0")!

    let request = URLRequest(url: url)
    
    let (data, _) = try await URLSession.shared.data(for: request)
        //data.forEach(country in {
        //print(country.rawValue)
    //})
    
    let decoder = JSONDecoder()
    
    return try decoder.decode([Country].self, from: data)
}

var results = try await fetchRemoteCountries()

//print(results.data.count)
//print(results.data.self)

results.forEach { country in
    print(country.countryID)
    print(country.countryName)
    print(country.countryLogo)
}


print("Hello, World!")

