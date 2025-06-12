//
//  WeatherViewModel.swift
//  SwiftyWeather
//
//  Created by Laura Steiner on 6/11/25.
//

import Foundation

@Observable
class WeatherViewModel: Codable {
	var urlString = "https://api.open-meteo.com/v1/forecast?latitude=42.33467401570891&longitude=-71.17007347605109&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m&hourly=uv_index&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=auto"
	var isLoading = false
	var temperature: Double = 0
	var feelsLike: Double = 0
	var windspeed: Double = 0
	var weatherCode: Int = 0
	
	private struct Weather: Codable {
		var current: Current
	}
	
	struct Current: Codable {
		var temperature_2m: Double
		var apparent_temperature: Double
		var weather_code: Int
		var wind_speed_10m: Double
	}
	
	func getData() async {
		isLoading = true
		guard let url = URL(string: urlString) else {
			print("ERROR -- Could not create URL from \(urlString)")
			isLoading = false
			return
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			guard let weather = try? JSONDecoder().decode(Weather.self, from: data) else {
				print("ERROR -- could not decode data from \(urlString)")
				isLoading = false
				return
			}
			Task { @MainActor in
				self.temperature = weather.current.temperature_2m
				self.feelsLike = weather.current.apparent_temperature
				self.windspeed = weather.current.wind_speed_10m
				self.weatherCode = weather.current.weather_code
				isLoading = false
				print("Temperature is \(self.temperature)")
			}
			
		} catch {
			print("ERROR -- Could not get data from \(urlString): \(error.localizedDescription)")
			isLoading = false
		}
	}
	
	
}

/*
 @Observable
 class MonstersViewModel {
 var urlString = "https://www.dnd5eapi.co/api/2014/monsters"
 static var baseURL = "https://www.dnd5eapi.co"
 var count = 0
 var isLoading = false
 var monsters: [Monster] = []
 
 // This works, but the test says to load when View appears.
 
 //	init(){
 //		Task {
 //			await self.getData()
 //		}
 //	}
 
 private struct Returned: Codable {
 var count: Int
 var results: [Monster]
 }
 
 func getData() async {
 isLoading = true
 guard let url = URL(string: urlString) else {
 print("ERROR -- Could not create URL from \(urlString)")
 isLoading = false
 return
 }
 
 do {
 let (data, _) = try await URLSession.shared.data(from: url)
 guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
 print("ERROR -- could not decode data from \(urlString)")
 isLoading = false
 return
 }
 Task { @MainActor in
 self.count = returned.count
 self.monsters = returned.results
 isLoading = false
 }
 
 } catch {
 print("ERROR -- Could not get data from \(urlString): \(error.localizedDescription)")
 isLoading = false
 }
 }
 
 }
 
 */
