//
//  ContinentsDataModel.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-19.
//
import SwiftUI
import Combine

struct PostRegion: Codable, Identifiable {
    let id: Int
    let region: String
    let image: String?
    let description: String
    let area: Int
    let population: Int
    let languages: String
    let populationDensity: Int

    enum CodingKeys: String, CodingKey {
        case id = "id_region", region, image, description, area, population, languages, populationDensity = "population_density"
    }
}

class RegionsDataModel: ObservableObject {
    @Published var regions: [PostRegion] = []
    
    init() {
        fetchRegionsData()
    }
    
    private func fetchRegionsData() {
        
        guard let url = URL(string: "https://countries.tusmodelos.com/regions_data") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let data = data {
                do {
                    let decodedDictionary = try JSONDecoder().decode([String: PostRegion].self, from: data)
                    let decodedArray = Array(decodedDictionary.values)

                    DispatchQueue.main.async {
                        self?.regions = decodedArray.sorted { $0.id < $1.id }
                        print(self?.regions ?? [])
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
        
    } // End fetchRegionData
    
    // Function to get all countries by idRegion
    func getRegionById(idRegion: Int) -> [PostRegion] {
        return regions.filter { $0.id == idRegion }
    }
}
