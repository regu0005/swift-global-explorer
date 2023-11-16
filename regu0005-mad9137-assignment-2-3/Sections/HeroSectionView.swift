//
//  HeroSectionView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-14.
//

import SwiftUI

struct HeroSectionView: View {
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        VStack(alignment: .leading, spacing: 10) {
                    Image("heroImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Text("Explore the World")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    Text("Discover information about countries, continents, and more.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
    }
}

#Preview {
    HeroSectionView()
}
