//
//  RootViewController.swift
//  culturetrip
//
//  Created by Yael Bilu Eran on 06/11/2020.
//

import UIKit

class RootViewController: UIViewController {
    //  MARK: outlets
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.layer.cornerRadius = 8
            startButton.layer.shadowOpacity = 0.8
            startButton.layer.shadowOffset = CGSize(width: 1, height: 1)
            startButton.layer.borderWidth = 2
            startButton.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    override func viewDidLoad() {
        title = "culturetrip"
    }
    
    @IBAction func startTapped() {
        DataProvider.shared.fetchData { result in
            switch result {
            case .success(let articales):
                guard let articales = articales else { return }
                print(articales)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
}


