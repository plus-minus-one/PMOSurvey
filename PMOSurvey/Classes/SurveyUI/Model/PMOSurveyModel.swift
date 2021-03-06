//
//  PMOSurvey.swift
//  PMOSurvey
//
//  Created by plusminusone on 11/4/20.
//

import Foundation

struct PMOSurveyModel : Decodable {

    let active:Bool
    let question: String
    let options: [String]
    var is_multi_selectable: Bool?
    var survey_id: String?
}
