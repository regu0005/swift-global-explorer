//
//  HeroSectionView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-14.
//

import SwiftUI

struct HeroSectionView: View {
    @ObservedObject var countriesDataModel: CountriesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    
    var body: some View {
            ZStack(alignment: .topTrailing) {
                Image("home_world_03")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                
                NavigationLink(destination: FavoritesView(favoritesManagerModel: favoritesManagerModel, countriesDataModel: countriesDataModel)) {
                    Image(systemName: "heart")
                        .font(.system(size: 30))
                        .padding(.horizontal, 70)
                        .foregroundColor(.white)
                }
                .padding(.top, 54)
                .padding(.horizontal,20)
                NavigationLink(destination: CountriesGeneralListView(countriesDataModel: countriesDataModel, favoritesManagerModel: favoritesManagerModel)) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 30))
                        .padding(.trailing, 20)
                        .foregroundColor(.white)
                }
                .padding(.top, 54)
                .padding(.horizontal,20)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Explore the World")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top,15)
                
                Text("Discover information about countries, continents, and more.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
    }
}

#Preview {
    HeroSectionView(countriesDataModel: CountriesDataModel(), favoritesManagerModel: FavoritesManagerModel())
}
