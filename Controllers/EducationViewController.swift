//
//  EducationViewController.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import UIKit

class EducationViewController: UIViewController {

//MARK:- Class Properties
    var itemCount = 1
    var educationDetails: EducationModel?
    var accomplishmentArray: [String.SubSequence]?
    
//MARK:- IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addNewItemButton: UIButton!
    
//MARK:- Base Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

//MARK:- Class Methods
extension EducationViewController{
    
    fileprivate func initialSetup(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        itemCount = AppManager.shared.resumeData.educationData?.educationPlaceDetails.count ?? 1
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.title = "Education"
        
    }
    
    func saveDataIntoArray(completion: @escaping (Bool)-> Void){
        
        var response = false
        educationDetails = EducationModel(title: titleTextField.text ?? "")
        
        for (index) in 0 ..< itemCount {
            let indexPath = IndexPath(item: index, section: 0)
            guard let cell = self.collectionView.cellForItem(at: indexPath) as? EducationCollectionViewCell else { return }
            
            if cell.degreeTextField.text != "" && cell.schoolTextField.text != "" && cell.dateTextField.text != "" && cell.accomplishmentTextView.text != "" {
                
                accomplishmentArray = cell.accomplishmentTextView.text.split(separator: "\n")
                
                let educationPlace = EducationPlaceDetailsModel(degree: cell.degreeTextField.text ?? "", school: cell.schoolTextField.text ?? "", date: cell.dateTextField.text ?? "", accomplishment: accomplishmentArray ?? [String.SubSequence]())
                
                self.educationDetails?.educationPlaceDetails.append(educationPlace)
                response = true
            }
            else {
                
                if cell.degreeTextField.text == ""{
                    
                    cell.degreeTextField.layer.borderWidth = 0.5
                    cell.degreeTextField.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
                }
                
                if cell.schoolTextField.text == "" {
                    
                    cell.schoolTextField.layer.borderWidth = 0.5
                    cell.schoolTextField.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
                }
                
                if cell.dateTextField.text == "" {
                    
                    cell.dateTextField.layer.borderWidth = 0.5
                    cell.dateTextField.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
                }
                
                if cell.accomplishmentTextView.text == "" {
                    
                    cell.accomplishmentTextView.layer.borderWidth = 0.5
                    cell.accomplishmentTextView.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
                }
                response = false
            }
        }
        
        AppManager.shared.resumeData.educationData = educationDetails
            completion(response)
    }
    
    @objc func doneButtonPressed(sender: AnyObject){
        
        saveDataIntoArray { (response) in
            if response == true {
                
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

//MARK:- UICollectionViewDataSource
extension EducationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "educationCollectionViewCell", for: indexPath) as! EducationCollectionViewCell
        let education = AppManager.shared.resumeData.educationData?.educationPlaceDetails[indexPath.row]
        if education != nil {
            
            cell.accomplishmentTextView.text = ""
            cell.configureCell(education: education ?? EducationPlaceDetailsModel())
        }
        else {
            
            cell.configureCell(education: EducationPlaceDetailsModel())
        }
        cell.cellDelegate = self
        return cell
    }
}

//MARK:- EducationCollectionViewCellDelegate
extension EducationViewController: EducationCollectionViewCellDelegate{
    
    func didTapOnButton(cell: EducationCollectionViewCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        collectionView.deleteItems(at: [indexPath])
        itemCount -= 1
        collectionView.reloadData()
    }
}

//MARK:- UICollectionViewDelegate
extension EducationViewController: UICollectionViewDelegate {
    
    
    
}

extension EducationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.width)
    }
    
}

//MARK:- IBActions
extension EducationViewController{
    
    @IBAction func addNewItemButtonPressed(_ sender: Any) {
        itemCount += 1
        collectionView.reloadData()
    }
    
}

