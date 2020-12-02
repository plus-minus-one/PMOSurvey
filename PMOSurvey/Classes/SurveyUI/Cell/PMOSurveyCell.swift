//
//  PMOSurveyCell.swift
//  PMOSurvey
//
//  Created by plusminusone on 11/4/20.
//

import UIKit

class PMOSurveyCell: UITableViewCell {

    var optionLabel: UILabel = UILabel()
    var optionTickView: UIImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Setup Method
extension PMOSurveyCell{
    func configureUI(){
        addSubview(optionTickView)
        optionTickView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionTickView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32),
            optionTickView.heightAnchor.constraint(equalToConstant: 24),
            optionTickView.widthAnchor.constraint(equalToConstant: 24),
            optionTickView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        addSubview(optionLabel)
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionLabel.leftAnchor.constraint(equalTo: optionTickView.rightAnchor, constant: 8),
            optionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            optionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            optionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
        optionLabel.numberOfLines = 0
    }
}
