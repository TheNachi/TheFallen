//
//  MeteorViewModel.swift
//  TheFallen
//
//  Created by Munachimso Ugorji on 23/09/2021.
//

import Foundation

class MeteorViewModel {
    private var meteorList: [MeteorModel] = []
    private var meteorNetworkService: MeteorNetworkService?
    weak var delegate: MeteorViewModelDelegate?
    var selectedIndex: Int = 0
    
    init(with meteorNetworkService: MeteorNetworkService?) {
        self.meteorNetworkService = meteorNetworkService
        self.meteorNetworkService?.delegate = self
    }
    
    public func getMeteors() {
        guard let meteorNetworkService = self.meteorNetworkService else { return }
        meteorNetworkService.getMeteors()
    }
    
    private func updateMeteorList(with meteors: [MeteorModel]) {
        self.meteorList = meteors.filter({ meteors in
            meteors.mass != nil && meteors.year != nil && String(meteors.year!.prefix(10)).toDate() != nil && Int(meteors.year!.prefix(4))! > 1900
        })
        
        self.sortByDate()
    }
    
    public func updateFromFavourites() {
        self.meteorList = FavouritesManager.shared.getFavourites()
    }
    
    public func sortByDate() {
        meteorList = meteorList.sorted { String($0.year!.prefix(10)).toDate()! < String($1.year!.prefix(10)).toDate()!}
    }
    
    public func sortByMass() {
        meteorList = meteorList.sorted { Double($0.mass!)! < Double($1.mass!)! }
    }
    
    public func getMeteorCount() -> Int {
        return self.meteorList.count
    }
    
    public func getMeteor(index: Int) -> MeteorModel {
        return self.meteorList[index]
    }
    
    public func getMeteorCellViewModel(index: Int) -> MeteorCellViewModel {
        return MeteorCellViewModel(with: self.getMeteor(index: index))
    }
}

extension MeteorViewModel: MeteorNetworkServiceDelegate {
    func onGetMeteors(response: [MeteorModel]) {
        self.updateMeteorList(with: response)
        self.delegate?.meteorsGotten()
    }
}

protocol MeteorViewModelDelegate: AnyObject {
    func meteorsGotten()
}
