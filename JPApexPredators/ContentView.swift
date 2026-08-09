//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Krishnanunni K A on 28/07/26.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText = ""
    @State var currentSelection = APType.all
    
    @State var isAlphabetical: Bool = false
    var filteredDino:[ApexPredator] {
        predators.filter(by: currentSelection)
        predators.sort(by: isAlphabetical)
        return predators.searchDino(for: searchText)
    }
    
    var body: some View {
        NavigationStack{
            List(filteredDino){ predator in
                NavigationLink {
                    
                    DetailView(predator: predator)
                    
                }label: {
                    HStack{
                        //dinasor image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading){
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal,13)
                                .padding(.vertical,5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                            
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        withAnimation {
                            isAlphabetical.toggle()
                        }
                    }label: {
                        if isAlphabetical {
                            Image(systemName: "textformat.alt")
                        }else{
                            Image(systemName: "film")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu{
                        Picker("Picker", selection: $currentSelection.animation()) {
                            ForEach(APType.allCases){ type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    }label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
