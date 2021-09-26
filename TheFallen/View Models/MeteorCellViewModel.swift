//
//  MeteorCellViewModel.swift
//  TheFallen
//
//  Created by Munachimso Ugorji on 23/09/2021.
//

import Foundation

struct MeteorCellViewModel {
    let meteorName: String
    let meteorCrashDate: String
    let meteorSize: String
    
    init(with model: MeteorModel?) {
        self.meteorName = model?.name ?? ""
        self.meteorCrashDate = model?.year?.dateStringConversation() ?? ""
        self.meteorSize = model?.mass ?? ""
    }
    
    func mergeDateAndSize() -> String {
        return meteorCrashDate + " · " + meteorSize + " kg"
    }
}
