//
//  ViewController.swift
//  TheFallen
//
//  Created by Munachimso Ugorji on 22/09/2021.
//

import UIKit

class MeteorViewController: UIViewController {
    @IBOutlet weak var meteorListTableView: UITableView!
    @IBOutlet weak var meteorSegementedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: MeteorViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        self.meteorListTableView.delegate = self
        self.meteorListTableView.dataSource = self
        let meteorNetworkService = MeteorNetworkService()
        self.viewModel = MeteorViewModel(with: meteorNetworkService)
        self.viewModel?.delegate = self
        self.viewModel?.getMeteors()
        self.setupView()
    }
    
    func setupView() {
        self.title = StringConstants.meteors.rawValue
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: StringConstants.segmentTextColor.rawValue)]
        meteorSegementedControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for: .normal)
        meteorSegementedControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for: .selected)
        let rightButton = UIBarButtonItem(image: UIImage(systemName: StringConstants.goForward.rawValue), style: .plain, target: self, action: #selector(self.refreshData))
        self.navigationItem.rightBarButtonItem  = rightButton
        rightButton.tintColor = UIColor.white
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        guard let vModel = viewModel else { return }
        if sender.selectedSegmentIndex == 0 {
            vModel.sortByDate()
            meteorListTableView.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            vModel.sortByMass()
            meteorListTableView.reloadData()
        }
    }
    
    @objc func refreshData() {
        guard let vModel = viewModel else { return }
        self.activityIndicator.startAnimating()
        vModel.getMeteors()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vModel = viewModel else { return }
        if segue.identifier == StringConstants.goToMap.rawValue,
           let meteeorMapVC = segue.destination as? MeteorMapViewController {
            meteeorMapVC.viewModel = MeteorMapViewModel(with: vModel.getMeteor(index: vModel.selectedIndex))
        }
    }
}

extension MeteorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vModel = self.viewModel else { return 0 }
        return vModel.getMeteorCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vModel = viewModel else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.meteorListCell.rawValue, for: indexPath)
        
        if let meteorCell = cell as? MeteorListTableViewCell {
            meteorCell.bindViewModel(with: vModel.getMeteorCellViewModel(index: indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vModel = viewModel else { return }
        vModel.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: StringConstants.goToMap.rawValue, sender: self)
    }
}

extension MeteorViewController: MeteorViewModelDelegate {
    func meteorsGotten() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.meteorListTableView.reloadData()
        }
    }
}
