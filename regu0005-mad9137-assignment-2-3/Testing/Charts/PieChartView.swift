//
//  PieChartView.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-20.
//


import Charts
import SwiftUI


struct PieChartView: View {
    var wineTypes = WineType.all
    var body: some View {
        NavigationStack {
            VStack {
                Chart(wineTypes) { wineType in
                    SectorMark(
                        angle: .value("In Stock", wineType.inStock),
                        angularInset: 1
                    )
                    .annotation(position: .overlay) {
                        Text("\(wineType.inStock)")
                            .foregroundStyle(.white)
                    }
                        .foregroundStyle(wineType.color)
                }
                VStack(alignment: .leading) {
                    ForEach(wineTypes) { wineType in
                        Label(wineType.name, systemImage: "square.fill")
                            .foregroundStyle(wineType.color)
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Pie Chart")
        }
    }
}

#Preview {
    PieChartView()
}
