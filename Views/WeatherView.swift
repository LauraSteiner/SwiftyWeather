//
//  ContentView.swift
//  SwiftyWeather
//
//  Created by Laura Steiner on 6/11/25.
//

import SwiftUI
import SwiftData

struct WeatherView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
	@State var weatherVM = WeatherViewModel()

    var body: some View {
		NavigationStack{
			ZStack {
				Color.cyan
					.opacity(0.75)
					.ignoresSafeArea()
				VStack{
					Image(systemName: "cloud.sun.rain.fill")
						.resizable()
						.scaledToFit()
						.padding(.horizontal)
						.symbolRenderingMode(.multicolor)
					Text("Wild Weather")
						.font(.largeTitle)
					Group{
						//Text("\(weatherVM.temperature)", format: .number.rounded(increment: 1.0)) +
						//Text("\(100)", format: .number.rounded(increment: 1.0)) +
						Text(weatherVM.temperature, format: .number.rounded(increment: 1.0)) +
						Text("°F")
					}
						.font(.system(size: 150, weight: .thin, design: .default))
					Group{
						Text("Wind ") +
						Text(weatherVM.windspeed, format: .number.rounded(increment: 1.0)) +
						Text(" mph  - Feels Like ") +
						Text(weatherVM.feelsLike, format: .number.rounded(increment: 1.0)) +
						Text("°F")
					}
						.font(.title2)
						.padding(.bottom)
				}
				.toolbar{
					ToolbarItem(placement: .topBarTrailing) {
						Button {
							//
						} label: {
							Image(systemName: "gear")
						}
						
					}
				}
			}
			.tint(.white)
			.foregroundStyle(.white)
			.task{
				await weatherVM.getData()
			}
		
		}
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    WeatherView()
        .modelContainer(for: Item.self, inMemory: true)
}
