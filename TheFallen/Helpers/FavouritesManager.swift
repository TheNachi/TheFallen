//
//  FavouritesManager.swift
//  TheFallen
//
//  Created by Munachimso Ugorji on 25/09/2021.
//

import Foundation

struct FavouritesManager {
    static let shared = FavouritesManager()
    private let userDefaults = UserDefaults.standard
    
    func toggleFavourites(meteor: MeteorModel) {
        guard let modelString = self.convertToJSONString(meteor: meteor) else { return }
        var favourites = userDefaults.object(forKey: "FAVOURITES") as? [String] ?? []
        if let index = favourites.firstIndex(of: modelString) {
            favourites.remove(at: index)
            userDefaults.set(favourites, forKey: "FAVOURITES")
        } else {
            favourites.append(modelString)
            userDefaults.set(favourites, forKey: "FAVOURITES")
        }
    }
    
    func isFavourite(meteor: MeteorModel) -> Bool {
        guard let modelString = self.convertToJSONString(meteor: meteor) else { return false }
        let favourites = userDefaults.object(forKey: "FAVOURITES") as? [String] ?? []
        return favourites.contains(modelString)
    }

    func getFavourites() -> [MeteorModel] {
        let favourites = userDefaults.object(forKey: "FAVOURITES") as? [String] ?? []
        return favourites.map { favourite in
            self.convertToModel(meteorString: favourite)!
        }
    }
    
    func convertToJSONString(meteor: MeteorModel) -> String? {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(meteor)
            let json = jsonData.base64EncodedString()
            return json
        } catch {
            print(error)
        }
        return nil
    }
    
    func convertToModel(meteorString: String) -> MeteorModel? {
        let data = Data(base64Encoded: meteorString),
            decoder = JSONDecoder()
        do {
            let metoerModel = try decoder.decode(MeteorModel.self, from: data!)
            return metoerModel
        } catch {
            print(error)
        }
        return nil
    }
}
