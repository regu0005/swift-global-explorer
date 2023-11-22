//
//  FavoritesManagerModel.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-21.
//

import Combine
import Foundation

class FavoritesManagerModel: ObservableObject {
    @Published var favorites: [Int: Bool] = [:]
    
    private let favoritesKey = "FavoritesKey"

    func toggleFavorite(countryID: Int) {
        favorites[countryID] = !(favorites[countryID] ?? false)
        saveToFavorites()
    }

    init() {
        loadFavorites()
    }
    
    func getFavorites() -> [Int: Bool] {
        return favorites.filter { $0.value == true }
                        // Reduce.- Create the dictionary of the filtered array, this is in tuples
                        .reduce(into: [Int: Bool]()) { result, current in
                            result[current.key] = current.value
                        }
    }
    
    private func saveToFavorites() {
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("Error encoding favorites: \(error)")
        }
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            do {
                self.favorites = try JSONDecoder().decode([Int: Bool].self, from: data)
            } catch {
                print("Error decoding favorites: \(error)")
            }
        }
    }
}
