//
//  ViewController.swift
//  PMOSurvey
//
//  Created by support@plusminusone.coon 11/07/2020.
//  Copyright (c) 2020 support@plusminusone.co. All rights reserved.
//

import UIKit
import PMOSurvey

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openSurvey(_ sender: Any) {
        var prop = PMOSurveyProperties()
        prop.plist_key = "pmo_survey"
        prop.enable_button_color = UIColor(red: 238.0/256.0, green: 21.0/256.0, blue: 149.0/256.0, alpha: 1)
        prop.disable_button_color = UIColor(red: 253.0/256.0, green: 232.0/256.0, blue: 244.0/256.0, alpha: 1)
        PMOSurvey.configure(prop)
        PMOSurvey.shared.isActive { [weak self] (active) in
            guard let strongSelf = self else { return }
            if active{
                PMOSurvey.shared.show(strongSelf, delegate: strongSelf)
            }else{
                let alertController = UIAlertController(title: "Firebase Error", message: "Please complete your Firebase integration!", preferredStyle: .alert)
                let gotoAction = UIAlertAction(title: "Go to Website", style: .default) { (action) in
                    if let url = URL(string: "https://github.com/plus-minus-one/PMOSurvey") {
                        UIApplication.shared.openURL(url)
                    }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                alertController.addAction(gotoAction)
                alertController.addAction(cancelAction)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension ViewController:PMOSurveyDelegate{
    func respondentDidEndSurvey(_ response: PMORespondent?, error: Error?) {
        guard let res = response else {
            return
        }
        self.questionLabel.text = res.question
        if let firstAns = res.answer.first{
            self.answerLabel.text = firstAns
        }
        PMOSurvey.shared.close()
    }
}
