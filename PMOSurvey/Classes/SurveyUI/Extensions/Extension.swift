//
//  Extension.swift
//  Baby Journal
//
//  Created by plusminusone on 11/7/20.
//  Copyright © 2020 PlusMinusOne. All rights reserved.
//

import UIKit

internal extension UIViewController {
    class var nibName: String {
        return String(describing: self)
    }
}

internal extension UIView {
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    class var nibName: String {
        return String(describing: self)
    }
    
    class var nibInstance: UINib {
        return UINib(nibName: self.nibName, bundle: nil)
    }
}

internal extension UINavigationBar {
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}

extension UIImage {
    public class func named(_ name: String) -> UIImage? {
        return UIImage.init(named: name, in: Bundle.mainSdk, compatibleWith: nil)
    }
    
    public class var cancel: UIImage? {
        return self.named("pmo_cancel")
    }
    
    public class var selected: UIImage? {
        return self.named("pmo_selected")
    }
    
    public class var unselected: UIImage? {
        return self.named("pmo_unselected")
    }
}

extension Bundle {
    class var mainSdk: Bundle {
        let bundle = Bundle.init(for: PMOSurveyViewController.self)
        let bundleUrl = bundle.url(forResource: "PMOSurvey", withExtension: "bundle")
        return Bundle.init(url: bundleUrl!)!
    }
}
