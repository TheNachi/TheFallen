//
//  MeteorFavouritesViewController.swift
//  TheFallen
//
//  Created by Munachimso Ugorji on 24/09/2021.
//

import UIKit

class MeteorFavouritesViewController: UIViewController {
    @IBOutlet weak var meteorFavouritesTableView: UITableView!
    private var viewModel = MeteorViewModel(with: nil)
    @IBOutlet weak var NoFavouriteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourites"
        self.meteorFavouritesTableView.dataSource = self
        self.meteorFavouritesTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateFromFavourites()
        meteorFavouritesTableView.isHidden = viewModel.getMeteorCount() != 0 ? false : true
        meteorFavouritesTableView.reloadData()
        NoFavouriteView.isHidden = viewModel.getMeteorCount() == 0 ? false : true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMapFromFavourites",
           let meteeorMapVC = segue.destination as? MeteorMapViewController {
            meteeorMapVC.viewModel = MeteorMapViewModel(with: viewModel.getMeteor(index: viewModel.selectedIndex))
        }
    }

}

extension MeteorFavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMeteorCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MeteorFavouritesTableViewCell.identifier, for: indexPath)
        
        if let meteorFavouriteCell = cell as? MeteorFavouritesTableViewCell {
            meteorFavouriteCell.bindViewModel(with: viewModel.getMeteorCellViewModel(index: indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "goToMapFromFavourites", sender: self)
    }
}
