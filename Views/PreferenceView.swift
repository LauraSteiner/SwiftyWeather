//
//  PreferenceView.swift
//  SwiftyWeather
//
//  Created by Laura Steiner on 6/12/25.
//

import SwiftUI
import SwiftData

struct PreferenceView: View {
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) var modelContext
	
	@State private var locationName = ""
	@State private var latString = ""
	@State private var longString = ""
	@State private var selectedUnit: UnitSystem = .imperial
	@State private var degreeUnitShowing = true
	@Query private var preferences: [Preference]
	
	
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
					Toggle(isOn: $degreeUnitShowing) {
						Text("Show F/C after temp value")
							.font(.title2)
					}
					
					Text("42°\(getDegreesString(degreeUnitShowing: degreeUnitShowing, selectedUnit: selectedUnit))")
						.font(.system(size: 150))
					HStack{
						Button("Save") {
							for preference in preferences {
								modelContext.delete(preference)
							}
							let newPreference = Preference(locationName: locationName, latString: latString, longString: longString, selectedUnit: selectedUnit, degreeUnitShowing: degreeUnitShowing)
							modelContext.insert(newPreference)
							dismiss()
						}
						.buttonStyle(.borderedProminent)
						.foregroundStyle(.white)
						Button("Cancel") {
							dismiss()
						}
						.buttonStyle(.bordered)
					}
					
					
					Spacer()
				}
				.foregroundStyle(.black)
				.padding()
				.onAppear{
					if preferences.count > 0 {
						print("There are saved preferences")
						let savedPreference = preferences[0]
						locationName = savedPreference.locationName
						latString = savedPreference.latString
						longString = savedPreference.longString
						selectedUnit = savedPreference.selectedUnit
						degreeUnitShowing = savedPreference.degreeUnitShowing
					}
				}
				.toolbar{
					ToolbarItem(placement: .topBarTrailing) {
						Button("Save") {
							for preference in preferences {
								modelContext.delete(preference)
							}
							//						var newPreference = Preference()
							//						newPreference.locationName = locationName
							//						newPreference.longString = longString
							//						newPreference.latString = latString
							//						newPreference.degreeUnitsShowing = degreeUnitsShowing
							//						newPreference.selectedUnit = selectedUnit
							
							let newPreference = Preference(locationName: locationName, latString: latString, longString: longString, selectedUnit: selectedUnit, degreeUnitShowing: degreeUnitShowing)
							modelContext.insert(newPreference)
							let _ = try? modelContext.save()
							dismiss()
							
						}
						.tint(.blue)
					}
		
					ToolbarItem(placement: .topBarLeading) {
						Button("Cancel") {
							dismiss()
						}
						.tint(.blue)
					}
				}
				.tint(.blue)
			}
		}
	}
	
	#Preview {
		PreferenceView()
			.modelContainer(Preference.preview)
	}
