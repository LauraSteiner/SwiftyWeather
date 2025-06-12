//
//  PreferenceView.swift
//  SwiftyWeather
//
//  Created by Laura Steiner on 6/12/25.
//

import SwiftUI

struct PreferenceView: View {
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) var modelContext
	
	@State private var locationName = ""
	@State private var latString = ""
	@State private var longString = ""
	@State private var selectedUnit: UnitSystem = .imperial
	@State private var degreeUnitsShowing = true
	
	
	var body: some View {
		NavigationStack{
			VStack(alignment: .leading) {
				TextField("location", text: $locationName)
					.font(.title)
					.textFieldStyle(.roundedBorder)
					.padding(.bottom)
				Text("Latitude:")
					.bold()
				TextField("latitude", text: $latString)
					.textFieldStyle(.roundedBorder)
				Text("Longitude:")
					.bold()
				TextField("longitude", text: $longString)
					.textFieldStyle(.roundedBorder)
				HStack{
					Text("Units")
						.bold()
					Spacer()
					Picker("Units", selection: $selectedUnit) {
						ForEach(UnitSystem.allCases) { unit in
							Text(unit.rawValue)
								.tag(unit)
						}
						.labelsHidden()
					}
				}
				.font(.title2)
				Toggle(isOn: $degreeUnitsShowing) {
					Text("Show F/C after temp value")
						.font(.title2)
				}
				
				Text("42°\(getDegreesString(degreeUnitsShowing: degreeUnitsShowing, selectedUnit: selectedUnit))")
					.font(.system(size: 150))
				
				
				Spacer()
			}
			.padding()
			.toolbar{
				ToolbarItem(placement: .topBarTrailing) {
					Button("Save") {
						//
					}
				}
				ToolbarItem(placement: .topBarLeading) {
					Button("Cancel") {
						//
					}
				}
			}
		}
	}
}

#Preview {
	PreferenceView()
		.modelContainer(Preference.preview)
}
