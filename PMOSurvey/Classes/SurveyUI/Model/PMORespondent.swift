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
    
    init(question: String, answer: [String]) {
        self.question = question
        self.answer = answer
    }
}
