//
//  RootViewController.swift
//  culturetrip
//
//  Created by Yael Bilu Eran on 06/11/2020.
//

import UIKit

class RootViewController: UIViewController {
    //  MARK: outlets
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


