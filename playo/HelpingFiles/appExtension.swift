//
//  appExtension.swift
//  playo
//
//  Created by manukant tyagi on 18/05/22.
//

import UIKit
//MARK: - UIView
extension UIView{
    func activityStartAnimating() {
        DispatchQueue.main.async {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.center = self.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            activityIndicator.tag = 475647
//            self.isUserInteractionEnabled = false
            self.addSubview(activityIndicator)
        }
    }
    
    func activityStopAnimating() {
        DispatchQueue.main.async{
            if let background = self.viewWithTag(475647){
                background.removeFromSuperview()
            }
            self.isUserInteractionEnabled = true
        }
    }
}

