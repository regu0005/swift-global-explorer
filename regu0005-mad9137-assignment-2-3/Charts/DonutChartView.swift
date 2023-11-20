//
//  DonutChartView.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-20.
//

import SwiftUI
import Charts

struct CountryData2: Identifiable {
    let id = UUID()
    let name: String
    let value: Int
    let color: Color
}

struct DonutChartView: View {
    var countryData: [CountryData2] = [
            CountryData2(name: "Country A", value: 50, color: .red),
            CountryData2(name: "Country B", value: 30, color: .green),
            CountryData2(name: "Country C", value: 20, color: .blue)
        ]
        @State private var selectedValue: Int?
        @State private var selectedCountry: CountryData2?

        var body: some View {
            NavigationStack {
                VStack {
                    Chart(countryData) { data in
                        SectorMark(
                            angle: .value("Value", data.value),
                            innerRadius: .ratio(0.65),
                            outerRadius: selectedCountry?.id == data.id ? 175 : 150,
                            angularInset: 1
                        )
                        .foregroundStyle(data.color)
                        .cornerRadius(10)
                    }
                    .chartAngleSelection(value: $selectedValue)
                    .chartBackground { _ in
                        if let selectedCountry {
                            VStack {
                                Text(selectedCountry.name)
                                    .font(.largeTitle)
                                    .foregroundStyle(selectedCountry.color)
                                Text("Value: \(selectedCountry.value)")
                            }
                        } else {
                            VStack {
                                Text("Select a segment")
                            }
                        }
                    }
                    .frame(height: 350)
                    Spacer()
                }
                .onChange(of: selectedValue) { _, newValue in
                    if let newValue {
                        withAnimation {
                            getSelectedCountry2(value: newValue)
                        }
                    }
                }
                .padding()
                .navigationTitle("Donut Chart")
            }
        }

        private func getSelectedCountry2(value: Int) {
            var cumulativeTotal = 0
            _ = countryData.first { data in
                cumulativeTotal += data.value
                if value <= cumulativeTotal {
                    selectedCountry = data
                    return true
                }
                return false
            }
        }
}

#Preview {
    DonutChartView()
}
