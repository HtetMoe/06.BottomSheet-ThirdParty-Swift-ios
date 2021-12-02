//
//  ViewController.swift
//  BottomSheet-ThirdParty
//
//  Created by Htet Moe Phyu on 02/12/2021.

import UIKit
import FittedSheets

class ViewController: UIViewController {
   
    //values Init
    var resultFilterList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //observe noti
        observeNotification(vc: self, name: RESULT_FILTER_NOTI)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        resultFilterList = (notification.userInfo?["resultList"] as? [String])!
        print("Observed : \(resultFilterList)")
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        openBottonSheet()
    }
    
    func openBottonSheet(){
        let filterVC = FilterBottomSheetViewController()
        //filterVC.subCategoryList = subCategoryList
        
        let bottomSheetVC = SheetViewController(controller: filterVC,
                                                sizes: [ .marginFromTop(250)],
                                                options: SheetOptions())
        
        bottomSheetVC.cornerRadius = 10
        self.present(bottomSheetVC, animated: true, completion: nil)
    }
    
}

