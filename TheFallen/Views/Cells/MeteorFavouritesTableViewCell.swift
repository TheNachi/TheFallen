//
//  MeteorFavouritesTableViewCell.swift
//  TheFallen
//
//  Created by Munachimso Ugorji on 25/09/2021.
//

import UIKit

class MeteorFavouritesTableViewCell: UITableViewCell {    
    @IBOutlet weak var meteorNameLabel: UILabel!
    @IBOutlet weak var meteorDateSizeLabel: UILabel!
    
    
    func bindViewModel(with viewModel: MeteorCellViewModel) {
        self.meteorNameLabel.text = viewModel.meteorName
        self.meteorDateSizeLabel.text = viewModel.mergeDateAndSize()
    }
}
