//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Krishnanunni K A on 09/11/26.
//

import SwiftUI
import MapKit


struct PredatorMap: View {
    @State var postition:MapCameraPosition
    @State var satellite =  false
    let predators = Predators()
    var body: some View {
        Map(position: $postition){
            ForEach(predators.apexPredators){ predator in
                Annotation(predator.name,
                           coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                    
                }
            }
        }.mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
            .overlay(alignment: .bottomTrailing) {
                Button {
                    satellite.toggle()
                }label: {
                    Image(systemName: satellite ? "globe.americas.fill" : "globe.americas" )
                        .font(.largeTitle)
                        .imageScale(.large)
                        .padding(3)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(radius: 3)
                        .padding()
                }
            }
            .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(postition: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location,
                                             distance: 1000,
                                             heading: 250,
                                             pitch: 80))).preferredColorScheme(.dark)
}
