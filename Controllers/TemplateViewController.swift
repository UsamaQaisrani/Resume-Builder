//
//  TemplateViewController.swift
//  Resume Builder
//
//  Created by Usama on 16/03/2021.
//

import UIKit

class TemplateViewController: UIViewController {
    
    
    //MARK:- Class Properties
    private let spacing:CGFloat = 9.0
    var documentsList =  [String]()
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var templateCollectionView: UICollectionView!
    
    //MARK:- Base Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

//MARK:- Class Methods
extension TemplateViewController {
    
    fileprivate func initialSetup(){
        
        self.navigationItem.title = "Templates"
        
        templateCollectionView.delegate = self
        templateCollectionView.dataSource = self
        
        let dataViewModel = DataViewModel()
        dataViewModel.getData { (filesList) in
            self.documentsList = filesList
        }
    }
}

//MARK:- CollectionView DataSource
extension TemplateViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documentsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = templateCollectionView.dequeueReusableCell(withReuseIdentifier: "templateCollectionViewCell", for: indexPath) as! TemplateCollectionViewCell
        cell.configureCell(documentList: documentsList[indexPath.row])
        return cell
    }
}

//MARK:- CollectionView Delegates
extension TemplateViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = self.storyboard?.instantiateViewController(identifier: "previewViewController") as! PreviewViewController
        storyboard.documentURLString = documentsList[indexPath.row]
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
}

//MARK:- CollectionView FlowLayout
extension TemplateViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow:CGFloat = 3
        let spacingBetweenCells:CGFloat = 9
        
        let totalSpacing = (1.5 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        
        if let collection = self.templateCollectionView{
            let width = (templateCollectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width*1.355)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}

//MARK:- IBActions
extension TemplateViewController {
    
    
}
