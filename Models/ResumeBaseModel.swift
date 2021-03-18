//
//  Base.swift
//  Resume Builder
//
//  Created by Usama on 12/03/2021.
//

import Foundation

class ResumeBaseModel {
    
    var contactInfoData: ContactInfoModel?
    var coverLetterData: CoverLetterModel?
    var objectiveData: ObjectiveModel?
    var qualificationsData: QualificationsModel?
    var workExperienceData: WorkExperienceModel?
    var educationData: EducationModel?
    var referenceData: ReferencesModel?
    var dataList: [WorkExperienceModel]?
    
    init(coverLetter: CoverLetterModel){
        self.coverLetterData = coverLetter
    }
    
    init(objectiveData: ObjectiveModel){
        self.objectiveData = objectiveData
    }
    
    init(qualificationsData: QualificationsModel){
        self.qualificationsData = qualificationsData
    }
    
    init(workExperience: WorkExperienceModel){
        self.workExperienceData = workExperience
    }
    
    init(educationData: EducationModel){
        self.educationData = educationData
    }
    
    init(referenceData: ReferencesModel) {
        self.referenceData = referenceData
    }
    
    init(contactInfo: ContactInfoModel) {
        self.contactInfoData = contactInfo
    }
    
    init(dataList: [WorkExperienceModel]){
        self.dataList = dataList
    }
    
    init() {
        
    }
}
