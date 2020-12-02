//
//  PMOSurveyViewController.swift
//  PMOSurvey
//

import UIKit

class PMOSurveyViewController: UIViewController {
    
    var titleLabel: UILabel = UILabel()
    var tableView: UITableView = UITableView()
    var primaryButton: UIButton = UIButton()
    
    var enableColor:UIColor = UIColor.blue
    var disableColor:UIColor = UIColor.gray
    
    weak var delegate:PMOSurveyDelegate?
    var survey:PMOSurveyModel = PMOSurveyModel(active: false, question: "", options: [])
    var selectedAnswers:[String] = []
    
    class func initViewController(_ survey:PMOSurveyModel) -> PMOSurveyViewController {
        let surveyController = PMOSurveyViewController()
        surveyController.survey = survey
        return surveyController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Setup Method
extension PMOSurveyViewController{
    func configureUI(){
        self.view.backgroundColor = UIColor.white
        configureNavigation()
        configureTitle()
        configurePrimaryButton()
        configureTableView()
    }
    
    func configureTitle(){
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        ])
        titleLabel.text = survey.question
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: primaryButton.topAnchor, constant: -8),
        ])
        tableView.register(PMOSurveyCell.self, forCellReuseIdentifier: PMOSurveyCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func configurePrimaryButton(){
        view.addSubview(primaryButton)
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.setTitle("Continue", for: .normal)
        primaryButton.titleLabel?.font = UIFont.systemFont(ofSize: 29, weight: .semibold)
        primaryButton.setTitleColor(UIColor.white, for: .normal)
        NSLayoutConstraint.activate([
            primaryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            primaryButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            primaryButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            primaryButton.heightAnchor.constraint(equalToConstant: 64.0)
        ])
        primaryButton.layer.cornerRadius = 8.0
        primaryButton.addTarget(self, action: #selector(self.handlePrimaryButton), for: .touchUpInside)
        enablePrimaryButton(false)
    }
    
    func configureNavigation(){
        self.navigationController?.navigationBar.transparentNavigationBar()
        let image = UIImage.cancel
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image:image, style: .plain, target: self, action: #selector(cancelAction))
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        
    }
}

// MARK: - TableView Delegate Methods
extension PMOSurveyViewController {
    @objc func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handlePrimaryButton(_ sender: Any) {
        self.delegate?.respondentDidEndSurvey(PMORespondent(question: survey.question, answer: selectedAnswers), error: nil)
    }
}

// MARK: - TableView Delegate Methods
extension PMOSurveyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return survey.options.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PMOSurveyCell.reuseIdentifier, for: indexPath) as? PMOSurveyCell {
            let option = survey.options[indexPath.item]
            cell.optionLabel.text = option
            if selectedAnswers.contains(option){
                cell.optionTickView.image = UIImage.selected
            }else{
                cell.optionTickView.image = UIImage.unselected
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

// MARK: - TableView DataSource Methods
extension PMOSurveyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = survey.options[indexPath.item]
        if survey.is_multi_selectable == true{
            if !selectedAnswers.contains(item){
                selectedAnswers.append(item)
            }else{
                selectedAnswers = selectedAnswers.filter{$0 != item}
            }
        }else{
            selectedAnswers.removeAll()
            selectedAnswers.append(item)
        }
        
        enablePrimaryButton(selectedAnswers.count > 0)
        tableView.reloadData()
    }
}

// MARK: - Target Methods
extension PMOSurveyViewController {
    func enablePrimaryButton(_ isEnabled:Bool){
        primaryButton.isEnabled = isEnabled
        if isEnabled == true{
            primaryButton.backgroundColor = enableColor
        }else{
            primaryButton.backgroundColor = disableColor
        }
    }
}


