//
//  Utils.swift
//  BottomSheet-ThirdParty
//
//  Created by Htet Moe Phyu on 02/12/2021.
//

import Foundation

//post noti
func postNotification(name : String, userInfo : NSDictionary){
    NotificationCenter.default.post(name: Notification.Name(name), object: nil, userInfo: (userInfo as! [AnyHashable : Any]))
}


//observe noti
func observeNotification(vc : ViewController, name : String){
    NotificationCenter.default.addObserver(vc, selector: #selector(vc.methodOfReceivedNotification(notification:)), name: Notification.Name(name), object: nil)
}
