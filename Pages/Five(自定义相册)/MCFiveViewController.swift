//
//  MCFiveViewController.swift
//  MCAPI
//
//  Created by MC on 2018/8/3.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

class MCFiveViewController: UIViewController {

    @IBOutlet weak var gotoLibraryButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        gotoLibraryButton.addTarget(self, action: #selector(gotoLibraryButtonClicked), for: .touchUpInside)
    }
    
    @objc func gotoLibraryButtonClicked() {
        let vc = MCPhotoPickerViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
