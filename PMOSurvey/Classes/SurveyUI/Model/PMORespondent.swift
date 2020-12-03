//
//  PMORespondent.swift
//  PMOSurvey
//
//  Created by plusminusone on 11/4/20.
//

import Foundation

open class PMORespondent{
    open var question: String
    open var answer: [String]
    open var surveyId: String?
    
    init(question: String, answer: [String], surveyId: String?) {
        self.question = question
        self.answer = answer
        self.surveyId = surveyId
    }
}
