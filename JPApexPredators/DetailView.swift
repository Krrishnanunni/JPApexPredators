//
//  DetailView.swift
//  JPApexPredators
//
//  Created by Krishnanunni K A on 08/08/26.
//

import SwiftUI

struct DetailView: View {
    var predator:ApexPredator
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
                    Text("Appears in :")
                        .font(.title3)
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
    DetailView(predator: Predators().apexPredators[10])
}
