//
//  PMOSurveyConfigManager.swift
//  PMOSurvey
//
//  Created by plusminusone on 11/4/20.
//

import Foundation
import FirebaseRemoteConfig
import FirebaseCore

typealias GetQuestionsSuccessBlock = ((PMOSurveyModel) -> Void)
typealias GetQuestionsErrorBlock = ((String) -> Void)

class PMOSurveyConfigManager {
    
    static let shared = PMOSurveyConfigManager()
    
    func fetch(_ key:String, duration:Int, completion: @escaping GetQuestionsSuccessBlock, failureBlock: @escaping GetQuestionsErrorBlock) {
        RemoteConfig.remoteConfig().configSettings = RemoteConfigSettings()
        RemoteConfig.remoteConfig().setDefaults(fromPlist: key)
        
        if (FirebaseApp.allApps == nil) {
            failureBlock("Error: Config not fetched")
            return
        }

        RemoteConfig.remoteConfig().fetch(withExpirationDuration: TimeInterval(duration)) { (status, error) -> Void in
            if status == .success {
                RemoteConfig.remoteConfig().activate { (status, error) in
                    //
                }
                let configString:String = RemoteConfig.remoteConfig().configValue(forKey: key).stringValue ?? ""//remoteConfig[key].stringValue ?? ""
                let data = configString.data(using: .utf8)
                do {
                    let config = try JSONDecoder().decode(PMOSurveyModel.self, from: data!)
                    completion(config)
                } catch {
                    failureBlock("Error: Config not fetched")
                }
            } else {
                failureBlock("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
    
}
