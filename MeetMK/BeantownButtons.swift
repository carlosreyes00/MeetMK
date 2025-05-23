//
//  BeantownButtons.swift
//  MeetMK
//
//  Created by Carlos Reyes on 5/4/25.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct BeantownButtons: View {
    @Binding var position: MapCameraPosition
    
    @Binding var searchResults: [MKMapItem]
    
    var visibleRegion: MKCoordinateRegion?
    
    var body: some View {
        HStack {
            Button {
                search(for: "playground")
            } label: {
                Label("Playgrounds", systemImage: "figure.and.child.holdinghands")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                search(for: "beach")
            } label: {
                Label("Beaches", systemImage: "beach.umbrella")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                position = .region(.boston)
            } label: {
                Label("Boston", systemImage: "building.2")
            }
            .buttonStyle(.bordered)
            
            Button {
                position = .region(.northShore)
            } label: {
                Label("North Shore", systemImage: "water.waves")
            }
            .buttonStyle(.bordered)
            
            LocationButton(.currentLocation) {

            }
        }
        .labelStyle(.iconOnly)
    }
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .physicalFeature
        request.region = visibleRegion ?? MKCoordinateRegion(
            center: .parking,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125))
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}

//#Preview {
//    BeantownButtons()
//}
