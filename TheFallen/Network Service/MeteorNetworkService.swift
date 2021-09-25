//
//  ApiService.swift
//  TheFallen
//
//  Created by Munachimso Ugorji on 23/09/2021.
//

import Foundation

struct MeteorNetworkService {
    private let BASEURL = "https://data.nasa.gov/resource/y77d-th95.json"
    weak var delegate: MeteorNetworkServiceDelegate?
    
    func getMeteors() {
            if let url = URL(string: BASEURL) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let meteorsData = data {
                        self.parseJSON(meteorsData: meteorsData)
                    }
                }
                task.resume()
            }
        }
    
    func parseJSON(meteorsData: Data) {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode([MeteorModel].self, from: meteorsData)
            delegate?.onGetMeteors(response: data)
        } catch {
            print(error)
        }
    }
}

protocol MeteorNetworkServiceDelegate: AnyObject {
    func onGetMeteors(response: [MeteorModel])
}
