//
//  Helpers.swift
//  SwiftyWeather
//
//  Created by Laura Steiner on 6/12/25.
//

import Foundation

enum UnitSystem: String, Codable, CaseIterable, Identifiable{
	case imperial = "Imperial"
	case metric = "Metric"
	
	var id: String { rawValue }
}

func getDegreesString( degreeUnitsShowing: Bool, selectedUnit: UnitSystem) -> String{
	if !degreeUnitsShowing {
		return ""
	}
	
	return selectedUnit == .imperial ? "F" : "C"
}
