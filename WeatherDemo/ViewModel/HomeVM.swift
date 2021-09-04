//
//  HomeViewModel.swift
//  WeatherDemo
//
//  Created by MacBook Pro on 9/3/21.
//

import Foundation
import UIKit
import CoreData

class HomeVM {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func getCities() -> [City] { 
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"City")
        do {
            guard let cities = try context.fetch(fetchRequest) as? [City] else { return [] }
            return cities
        } catch {
          print(error)
          return []
        }
    }
    
    func saveWeatherData(_ cityName:String,_ dic:[AnyHashable:Any]?) {
        guard let dic = dic as? [String:String] else { return }
        let info = WeatherInfo(context: context)
        info.desc = dic["description"]
        info.icon = dic["icon"]
        info.iconId = dic["iconId"]
        info.speed = String(format: "%.2f",Float(dic["speed"]!)!)
        info.temp = dic["temp"]!.fromKelvinToCelsius()
        info.humidity = dic["humidity"]! + " %"
        info.date = Date(timeIntervalSince1970:Double(dic["date"]!)!)
        let id = Int32(Int(dic["cityId"]!)!)
        info.cityId = id
        do {
            try context.save()
            print("Saved saveWeatherData")
        }
        catch {
            print("Error saving coredata : ",error)
        }
        
        saveCityWith(cityName,id)
        
    }
    
    func saveCityWith(_ name:String,_ id:Int32) {
        let london = City(context: context)
        london.name = name
        london.id = id
        do {
            try context.save() 
        }
        catch {
            print("Error saving coredata : ",error)
        }
    }
    
    func deleteCity(_ city:City) {
        context.delete(city)
        do {
            try context.save()
        }
        catch {
            print("Error saving coredata : ",error)
        }
    }
    
}
