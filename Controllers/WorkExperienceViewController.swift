//
//  WorkExperienceViewController.swift
//  Resume Builder
//
//  Created by Usama on 10/03/2021.
//

import UIKit

class WorkExperienceViewController: UIViewController {
    
    //MARK:- Class Properties
    var itemCount = 1
    var workExperience = WorkExperienceModel()
    var accomplishmentArray : [String.SubSequence]?
    
    //MARK:- IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addNewItemButton: UIButton!
    
    //MARK:- Base Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        initialSetup()
    }
}

//MARK:- Class Methods

extension WorkExperienceViewController{
    
    fileprivate func initialSetup(){
        
        self.itemCount = AppManager.shared.resumeData.workExperienceData?.workedPlacesDetails.count ?? 1
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.title = "Work Experience"
        
        if AppManager.shared.resumeData.workExperienceData != nil {
            
            titleTextField.text = AppManager.shared.resumeData.workExperienceData?.title
            
            for index in 0 ..< itemCount {
                
                let indexPath = IndexPath(item: index, section: 0)
                guard let cell = self.collectionView.cellForItem(at: indexPath) as? WorkExperienceCollectionViewCell else { continue }
                
                cell.positionTextField.text = AppManager.shared.resumeData.workExperienceData?.workedPlacesDetails[indexPath.row].position
                cell.subtitleTextField.text = AppManager.shared.resumeData.workExperienceData?.workedPlacesDetails[indexPath.row].subtitle
                cell.durationTextField.text = AppManager.shared.resumeData.workExperienceData?.workedPlacesDetails[indexPath.row].date
                AppManager.shared.resumeData.workExperienceData?.workedPlacesDetails[indexPath.row].accomplishment?.forEach({ (accomplishment) in
                    cell.accomplishmentTextView.text = accomplishment + "\n"
                })
            }
        }
    }
    
    fileprivate func saveDataIntoDataArray(completion: @escaping (Bool)->Void) {
        
        workExperience = WorkExperienceModel(title: titleTextField.text ?? "", experience: Float(0))
        var response = false
        for index in 0 ..< itemCount {
            
            let indexPath = IndexPath(item: index, section: 0)
            guard let cell = self.collectionView.cellForItem(at: indexPath) as? WorkExperienceCollectionViewCell else { continue }
            
            if cell.subtitleTextField.text != "" && cell.durationTextField.text != "" && cell.accomplishmentTextView.text != "" {
                
                accomplishmentArray = cell.accomplishmentTextView.text.split(separator: "\n")
                
                let workedPlace = WorkPlaceDetailsModel(position: cell.positionTextField.text ?? "", subtitle: cell.subtitleTextField.text ?? "", date: cell.durationTextField.text ?? "", accomplishment: accomplishmentArray ?? [String.SubSequence]())
                
                self.workExperience.workedPlacesDetails.append(workedPlace)
                AppManager.shared.resumeData.workExperienceData = workExperience
                response = true
            }
            
            else {
                
                cell.positionTextField.showError(textField: cell.positionTextField)
                
                cell.subtitleTextField.showError(textField: cell.subtitleTextField)
                
                cell.durationTextField.showError(textField: cell.durationTextField)
                
                cell.accomplishmentTextView.showError(textView: cell.accomplishmentTextView)
                
                response = false
            }
        }
        
        completion(response)
    }
    
    @objc func doneButtonPressed(sender: AnyObject){
        
        saveDataIntoDataArray { (response) in
            
            if response == true {
                
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

//MARK:- TableViewDelegate
extension WorkExperienceViewController: UICollectionViewDelegate {
    
    
    
}

extension WorkExperienceViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.width)
        
    }
}

//MARK:- TableViewDataSource
extension WorkExperienceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workExperienceCollectionViewCell", for: indexPath) as! WorkExperienceCollectionViewCell
        let work = AppManager.shared.resumeData.workExperienceData?.workedPlacesDetails[indexPath.row]
        
        cell.cellDelegate = self
        
        if work != nil {
            cell.accomplishmentTextView.text = ""
            cell.configureCell(workExperience: work ?? WorkPlaceDetailsModel(), index: indexPath )
        }
        else {
            cell.configureCell(workExperience: WorkPlaceDetailsModel(), index: indexPath)
        }
        return cell
    }
}

//MARK:- WorkExperienceCollectionViewCellDelegate
extension WorkExperienceViewController: WorkExperienceCollectionViewCellDelegate  {
    
    func didTapOnButton(cell: WorkExperienceCollectionViewCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        collectionView.deleteItems(at: [indexPath])
        itemCount -= 1
        collectionView.reloadData()
    }
}

//MARK:- IBActions
extension WorkExperienceViewController{
    
    @IBAction func addNewItemButtonPressed(_ sender: Any) {
        itemCount += 1
        collectionView.reloadData()
    }
}
