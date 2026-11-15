//
//  DetailView.swift
//  JPApexPredators
//
//  Created by Krishnanunni K A on 08/08/26.
//

import SwiftUI
import MapKit

struct DetailView: View {
    var predator:ApexPredator
    @State var position:MapCameraPosition
    @Namespace var namespace

    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                ZStack(alignment:.bottomTrailing){
                    
                    //cover bg of PredatorType
                    
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops: [
                                Gradient.Stop.init(color: .clear, location: 0.8),Gradient.Stop.init(color: .black, location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                            
                            
                        }
                        .background(
                            // top sroll blurr
                            Image(predator.type.rawValue)
                                .resizable()
                                .offset(y:-200)
                                .blur(radius: 10)
                        
                        
                               
                            
                        )
                    
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3.7)
                        .scaleEffect(x:-1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                    
                }
                
                VStack(alignment: .leading){
                    
                    Text(predator.name)
                        .font(.largeTitle)
                    // current location
                    NavigationLink{
                        PredatorMap(postition: .camera(MapCamera(centerCoordinate: predator.location,
                                                                 distance: 1000,
                                                                 heading: 250,
                                                                 pitch: 80))).preferredColorScheme(.dark)
                            .navigationTransition(.zoom(sourceID: 1, in: namespace))
                    }label: {
                        Map(position: $position){
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                            }
                        }
                        .frame(height: geo.size.height/5)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing , 5)
                            
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading,.bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(topLeadingRadius: 15, bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    .matchedTransitionSource(id: 1, in: namespace)
                    
                    
                    
                    Text("Appears in :")
                        .font(.title3)
                        .padding(.top)
                    ForEach(predator.movies, id: \.self){ movie in
                        Text("•"+movie)
                            .font(.subheadline)
                    }
                    
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top,15)
                    
                    ForEach(predator.movieScenes){ scene in
                        Text(scene.movie)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.vertical,2)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom,15)
                    }
                    Text("Read More:")
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                    
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
                
                
                
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    let predator = Predators().apexPredators[2]
    NavigationStack{
        DetailView(predator: predator,
                   position: .camera(
                    MapCamera(centerCoordinate:predator.location,
                              distance: 30000))
        )
    }
}
