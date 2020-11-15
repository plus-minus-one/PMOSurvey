//
//  PMOSurvey.swift
//  PMOSurvey
//
//  Created by plusminusone on 11/4/20.
//

import Foundation
import UIKit

public protocol PMOSurveyDelegate : class {
    func respondentDidEndSurvey(_ response:PMORespondent?, error:Error?)
}
 
public typealias PMOSurveyIsActiveBlock = ((Bool) -> Void)

public struct PMOSurveyProperties{
    public var plist_key:String?
    public var duration:Int?
    public var enable_button_color:UIColor?
    public var disable_button_color:UIColor?
    
    public init() {}
}

open class PMOSurvey {
    
    public static let shared = PMOSurvey()
    
    private static var properties:PMOSurveyProperties? = nil
    
    var survey:PMOSurveyModel?
    var viewControllerToPresent:UIViewController?
    
    public static func configure(_ properties:PMOSurveyProperties? = nil){
        self.properties = properties
    }
    
    public func isActive(completion: @escaping PMOSurveyIsActiveBlock){
        var key = "pmo_survey"
        var duration = 0
        if let properties = PMOSurvey.properties{
            if let plist_key = properties.plist_key{
                key = plist_key
            }
            if let expiration_duration = properties.duration{
                duration = expiration_duration
            }
        }
        PMOSurveyConfigManager.shared.fetch(key, duration: duration) { (survey) in
            self.survey = survey
            completion(true)
        } failureBlock: { (error) in
            print(error)
            completion(false)
        }
    }
    
    public func show(_ presenter:UIViewController, delegate:PMOSurveyDelegate, presentationStyle:UIModalPresentationStyle = .fullScreen){
        guard let safeSurvey = survey else { return }
        guard safeSurvey.active else { return }

        let viewController = PMOSurveyViewController.initViewController(safeSurvey)
        viewController.delegate = delegate
        if let properties = PMOSurvey.properties{
            if let enableColor = properties.enable_button_color{
                viewController.enableColor = enableColor
            }
            if let disableColor = properties.disable_button_color{
                viewController.disableColor = disableColor
            }
        }
        let navigationVC = UINavigationController(rootViewController: viewController)
        navigationVC.modalPresentationStyle = presentationStyle //or .overFullScreen for transparency
        self.viewControllerToPresent = navigationVC
        presenter.present(navigationVC, animated: true, completion: nil)
    }
    
    public func close(){
        viewControllerToPresent?.dismiss(animated: true, completion: nil)
    }
}
