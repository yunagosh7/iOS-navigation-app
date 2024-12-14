//
//  ContentView.swift
//  navigation-app
//
//  Created by Juan Cruz Vila on 13/12/2024.
//

import SwiftUI


struct ContentView: View {
    
    @State var places: [ApiNetwork.Place]? = nil
    
    @State var loading: Bool = true
    
    var body: some View {
        if loading {
            Spacer()
            ProgressView().tint(.cyan)
                .controlSize(.extraLarge)
                .padding(.top, 300)
        }
        NavigationStack {
            VStack {
                List(places ?? []) { place in
                    ZStack {
                        PlaceCard(place: place)
                        NavigationLink(destination: PlaceDetails()) {
                            EmptyView()
                        }.opacity(0)
                    }
                }
                .listStyle(.plain)
                .listRowBackground(Color.red)
                
            }
            .task {
                do {
                    places = try await ApiNetwork().getAllTouristicPlaces()
                   
                } catch {
                    print("Error al obtener los lugares: \(error)") // Evita usar `throw` aquí
                }
                loading = false
            }
        }
    }
    
}

#Preview {
    ContentView()
}
