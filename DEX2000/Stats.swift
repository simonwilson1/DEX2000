//
//  Stats.swift
//  DEX2000
//
//  Created by Simon Wilson on 27/02/2025.
//

import SwiftUI
import Charts

struct Stats: View {
    
    var pokemon: Pokemon
    
    var body: some View {
        Chart(pokemon.stats) { stat in
            BarMark(x: .value("value", stat.value), y: .value("Stat", stat.name))
                .annotation(position: .trailing) {
                    Text("\(stat.value)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.top, -5)
                }
        }
        .frame(height: 200)
        .padding([.horizontal, .bottom])
        .foregroundStyle(pokemon.typeColor)
        .chartXScale(domain: 0...pokemon.highestStat.value + 10)
    }
}

#Preview {
    Stats(pokemon: PersistenceController.previewPokemon)
}
