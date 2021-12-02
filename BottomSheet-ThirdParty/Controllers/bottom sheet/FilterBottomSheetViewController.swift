//
//  FilterBottomSheetViewController.swift
//  BottomSheet-ThirdParty
//
//  Created by Htet Moe Phyu on 02/12/2021.

import UIKit

class FilterBottomSheetViewController: UIViewController {
    
    //outlets Init
    @IBOutlet weak var filterCV: UICollectionView!
    
    //data Init
    var filterList = ["Filter one","Filter two",
                      "Filter three","Filter four","Filter five"];
    var resultFilterList = [String]()
    var isReset = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        filterCV.delegate   = self
        filterCV.dataSource = self
        
        filterCV.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
        
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        isReset = true
        resultFilterList.removeAll()
        filterCV.reloadData()
        
        print("Result : \(resultFilterList)")
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        //close bsheet
        dismiss(animated: true, completion: nil)
        
        //post noti
        postNotification(name: RESULT_FILTER_NOTI, userInfo: ["resultList": resultFilterList])
        
    }
}

extension FilterBottomSheetViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = filterCV.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! CollectionViewCell
        
        cell.filterNameLabel.text = filterList[indexPath.row]
        
        //setup border
        cell.layer.cornerRadius = 5
        
        if isReset{
            cell.layer.borderWidth = 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        return CGSize(width: width/2 - 20, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        isReset = false
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        
        //check filtered selected or not
        if(resultFilterList.contains(where: { selectedName -> Bool in
            selectedName == filterList[indexPath.row]
        })){ // if already exist, do remove
            
            if(resultFilterList.count > 0){
                for i in 0...resultFilterList.count - 1 {
                    if filterList[indexPath.row] == resultFilterList[i]{
                        resultFilterList.remove(at: i)
                        break
                    }
                }
            }
            
            //remove border
            cell?.layer.borderWidth = 0
        }
        else{ // append to list
            self.resultFilterList.append(self.filterList[indexPath.row])
            
            //set border
            cell?.layer.borderWidth = 1
            cell?.layer.borderColor = #colorLiteral(red: 0.05347145349, green: 0.5284157395, blue: 1, alpha: 1)
        }
        print("Result : \(resultFilterList)")
    }
}
