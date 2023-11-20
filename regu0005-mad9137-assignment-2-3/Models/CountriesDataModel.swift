//
//  CountriesDataModel.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-16.
//

import SwiftUI
import Combine

struct Language: Codable {
    var id: Int
    var language: String

    enum CodingKeys: String, CodingKey {
        case id = "id_language", language
    }
}

struct PostCountry: Codable, Identifiable {
    let id: Int
    var name: String
    var image: String?
    var flag: String
    var capital: String
    var population: Int
    var region: String
    var area: Int
    var latitude: String?
    var longitude: String?
    var urlMap: String?
    var shortDescription: String?
    var idRegion: Int?
    var languages: [Language]

    enum CodingKeys: String, CodingKey {
        case id = "id_country"
        case name, image, flag, capital, population, region, area, latitude, longitude, urlMap = "url_map", shortDescription = "short_description", idRegion = "id_region", languages
    }
}


class CountriesDataModel: ObservableObject {
    @Published var countries: [PostCountry] = []
    
    init() {
        fetchCountriesData()
    }

    // GET ALL THE COUNTRIES FROM THE JSON
    private func fetchCountriesData() {
        // The follow endpoint has the possibility to load all Countries data. This endpoint hast the follow options:
        // URL: https://countries.tusmodelos.com/countries_data
        // - limit = to get an specific quantity of countries
        // - ini = to get the countris begining in the row 'ini'
        // - haslocation = to ask only for countries that have latitude and longitude not null
        // -- value 1 = have location
        // -- value 0 = doesn't have location
        // Example: https://countries.tusmodelos.com/countries_data/index.php?limit=10&ini=5&haslocation=1
        
        // The follow endpoint has the possibility to load ONLY the location (latitude, longite) of each capital by Country.
        // This endpoint hast the follow options:
        // URL: https://countries.tusmodelos.com/countries_capital_location
        // - limit = to get an specific quantity of countries
        // - ini = to get the countris begining in the row 'ini'
        // - haslocation = to ask only for countries that have latitude and longitude not null
        // -- value 1 = have location
        // -- value 0 = doesn't have location
        // Example: https://countries.tusmodelos.com/countries_capital_location/index.php?limit=10&ini=5&haslocation=1
        
        
        guard let url = URL(string: "https://countries.tusmodelos.com/countries_data/index.php") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let data = data {
                do {
                    let decodedDictionary = try JSONDecoder().decode([String: PostCountry].self, from: data)
                    let decodedArray = Array(decodedDictionary.values)

                    DispatchQueue.main.async {
                        self?.countries = decodedArray.sorted { $0.id < $1.id }
                        //print(self?.countries ?? [])
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    // TODO Work on a possible simulated data just to display empty info with dummy info
                    //self?.useSimulatedData()
                }
            }
            // TODO Work on a possible error when data doesn't exist
//                else if let error = error {
//                print("Error fetching data: \(error.localizedDescription)")
//                self?.useSimulatedData()
//            }
        }.resume()
    }
    
    
    func getMostPopulatedCountries() -> [PostCountry] {
        return Array(countries
                .sorted { $0.population > $1.population }
                .prefix(6))
    }

    func getMostLargestCountries() -> [PostCountry] {
        return Array(countries
                .sorted { $0.area > $1.area }
                .prefix(6))
    }
    
    // Function to get all countries by idRegion
    func getCountriesByRegion(idRegion: Int) -> [PostCountry] {
        return countries.filter { $0.idRegion == idRegion }
    }
    
    func topCountriesSpeakingLanguage(worldwide languageId: Int) -> [PostCountry] {
            return countries
                .filter { $0.languages.contains(where: { $0.id == languageId }) }
                .sorted { $0.population > $1.population }
                .prefix(10)
                .map { $0 }
    }

    func topCountriesSpeakingLanguage(inRegion idRegion: Int, languageId: Int) -> [PostCountry] {
        return countries
            .filter { $0.idRegion == idRegion && $0.languages.contains(where: { $0.id == languageId }) }
            .sorted { $0.name < $1.name }
            .prefix(10)
            .map { $0 }
    }
}
