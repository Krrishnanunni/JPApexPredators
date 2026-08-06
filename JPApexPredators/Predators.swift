//
//  Predators.swift
//  JPApexPredators
//
//  Created by Krishnanunni K A on 29/07/26.
//
import Foundation
class Predators {
    var apexPredators: [ApexPredator] = []
    
    init(){
        decodeApexPredatorsData()
    }
    
    func decodeApexPredatorsData(){
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                apexPredators = try decoder.decode([ApexPredator].self, from: data)
            }catch{
                print("json decoding error ------->",error)
            }
        }
    }
}
