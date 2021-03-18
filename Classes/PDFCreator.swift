//
//  PDFCreator.swift
//  Resume Builder
//
//  Created by Usama on 17/03/2021.
//

import Foundation
import PDFKit

class PDFCreator{
    
    //MARK:- Class Properties
    
    static let shared = PDFCreator()
    let pageRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
    var bottomSpace = CGFloat()
    
    
    
    
    //MARK:- Class Methods
    
    func createResume() -> Data {
        
        var data: Data?
        let pdfMetaData = [
            kCGPDFContextCreator: "Usama",
            kCGPDFContextAuthor: "Usama"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        data = renderer.pdfData { (context) in
            context.beginPage()
            
            bottomSpace = addTitle(pageRect: pageRect)
            
            bottomSpace = drawContactInfo(bottomSpace: bottomSpace, context: context)
            
            bottomSpace = drawObjective(bottomSpace: bottomSpace, context: context)
            
            bottomSpace = drawKeyQualifications(bottomSpace: bottomSpace, context: context)
            
            bottomSpace = drawWorkExperience(bottomSpace: bottomSpace, context: context)
            
            bottomSpace = drawEducation(bottomSpace: bottomSpace, context: context)
            
            bottomSpace = drawReferences(bottomSpace: bottomSpace, context: context)
            
        }
        
        return data ?? Data()
    }
    
    func drawContactInfo(bottomSpace: CGFloat, context : UIGraphicsPDFRendererContext)->CGFloat{
        
        let contactInfo = AppManager.shared.resumeData.contactInfoData
        var bottomTextSpace = bottomSpace
        bottomTextSpace = addTextBelow(pageRect: pageRect, textTop: bottomTextSpace, text: "Phone: \(contactInfo?.phoneNumber ?? "0123456789")",context: context)
        bottomTextSpace = addTextBelow(pageRect: pageRect, textTop: bottomTextSpace, text: "Address: \(contactInfo?.address ?? "Your Address")", context: context)
        bottomTextSpace = addTextBelow(pageRect: pageRect, textTop: bottomTextSpace, text: "Email : \(contactInfo?.email ?? "someone@email.com")", context: context)
        return bottomTextSpace
    }
    
    func drawObjective(bottomSpace: CGFloat, context: UIGraphicsPDFRendererContext) -> CGFloat{
        
        let objectiveInfo = AppManager.shared.resumeData.objectiveData
        var bottomTextSpace = bottomSpace
        
        bottomTextSpace = addHeading(pageRect: pageRect, textTop: bottomTextSpace, text: objectiveInfo?.title ?? "Objectives: ",context: context)
        bottomTextSpace = addParagraphText(pageRect: pageRect, textTop: bottomTextSpace, text: objectiveInfo?.content ?? "Experienced professional seeking to fill a (name of position) position.",context: context)
        
        return bottomTextSpace
    }
    
    func drawKeyQualifications(bottomSpace: CGFloat, context: UIGraphicsPDFRendererContext)->CGFloat{
        
        let qualificationInfo = AppManager.shared.resumeData.qualificationsData
        var qualificationsCount = 0
        var bottomTextSpace = bottomSpace
        
        bottomTextSpace = addHeading(pageRect: pageRect, textTop: bottomSpace, text: qualificationInfo?.title ?? "Qualifications: ",context: context)
        
        qualificationInfo?.content?.forEach({ (qualification) in
            
            if qualificationsCount == 0 {
                
                bottomTextSpace = bulletPointText(pageRect: pageRect, textTop: bottomTextSpace, text: "\(qualification)", context: context)
                qualificationsCount += 1
            }
            else {
                bottomTextSpace = bulletPointText(pageRect: pageRect, textTop: bottomTextSpace, text: "\(qualification)", context: context)
                qualificationsCount += 1
            }
        })
        return bottomTextSpace
    }
    
    func drawWorkExperience(bottomSpace: CGFloat, context: UIGraphicsPDFRendererContext)->CGFloat{
        
        var bottomTextSpace = bottomSpace
        var workExperiencePlacesCount = 0
        let workExperienceInfo = AppManager.shared.resumeData.workExperienceData
        
        bottomTextSpace = addHeading(pageRect: pageRect, textTop: bottomSpace, text: workExperienceInfo?.title ?? "Work Experience", context: context)
        workExperiencePlacesCount = 0
        workExperienceInfo?.workedPlacesDetails.forEach({ (work) in
            
            addDate(pageRect: pageRect, textTop: bottomTextSpace, text: workExperienceInfo?.workedPlacesDetails[workExperiencePlacesCount].date ?? "")
            bottomTextSpace = addSubHeading(pageRect: pageRect, textTop: bottomTextSpace, text: workExperienceInfo?.workedPlacesDetails[workExperiencePlacesCount].position ?? "", context: context)
            workExperiencePlacesCount += 1
            
            if let accomplishments = work.accomplishment {
                for (_, accomplishment) in accomplishments.enumerated() {
                    
                    bottomTextSpace = bulletPointText(pageRect: pageRect, textTop: bottomTextSpace, text: "\(accomplishment)", context: context)
                }
            }
        })
        return bottomTextSpace
    }
    
    func drawEducation(bottomSpace: CGFloat, context: UIGraphicsPDFRendererContext)->CGFloat{
        
        var bottomTextSpace = bottomSpace
        let educationInfo = AppManager.shared.resumeData.educationData
        
        bottomTextSpace = addHeading(pageRect: pageRect, textTop: bottomTextSpace, text: educationInfo?.title ?? "Education: ", context: context)
        educationInfo?.educationPlaceDetails.forEach({ (education) in
            
            addDate(pageRect: pageRect, textTop: bottomTextSpace, text: education.date ?? "Date")
            bottomTextSpace = addSubHeading(pageRect: pageRect, textTop: bottomTextSpace, text: education.degree ?? "Your Degree", context: context)
            
            if let accomplishments = education.accomplishment {
                
                for (_, accomplishment) in accomplishments.enumerated() {
                    
                    bottomTextSpace = bulletPointText(pageRect: pageRect, textTop: bottomTextSpace, text: "\(accomplishment)", context: context)
                }
            }
        })
        return bottomTextSpace
    }
    
    func drawReferences(bottomSpace: CGFloat, context: UIGraphicsPDFRendererContext)->CGFloat{
        
        var bottomTextSpace = bottomSpace
        let referenceInfo = AppManager.shared.resumeData.referenceData
        
        bottomTextSpace = addHeading(pageRect: pageRect, textTop: bottomTextSpace, text: referenceInfo?.title ?? "References: ", context: context)
        bottomTextSpace = addTextBelow(pageRect: pageRect, textTop: bottomTextSpace, text: referenceInfo?.content ?? "Available upon Request", context: context)
        return bottomTextSpace
    }
    
    func addTitle(pageRect: CGRect) -> CGFloat {
        
        let contactInfo = AppManager.shared.resumeData.contactInfoData
        
        let titleFont = UIFont.systemFont(ofSize: 25, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(
            string: contactInfo?.name ?? "Your Name",
            attributes: titleAttributes
        )
        let titleStringSize = attributedTitle.size()
        let titleStringRect = CGRect(
            x: (pageRect.width - titleStringSize.width) / 2.0,
            y: 36,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        attributedTitle.draw(in: titleStringRect)
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addTextBelow(pageRect: CGRect, textTop: CGFloat, text: String, context: UIGraphicsPDFRendererContext) -> CGFloat{
        
        let textFont = UIFont.systemFont(ofSize: 9.0)
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: textFont]
        let attributedText = NSAttributedString(string: text, attributes: textAttributes)
        let textStringSize = attributedText.size()
        if textTop + textStringSize.height > 830{
            context.beginPage()
            let bottomSpace : CGFloat = 35.0
            let textStringRect = CGRect(x: 10, y: bottomSpace, width: textStringSize.width, height: textStringSize.height)
            attributedText.draw(in: textStringRect)
            return textStringRect.origin.y + textStringRect.size.height
            
        }
        else
        {
            let textStringRect = CGRect(x: 10, y: textTop+5, width: textStringSize.width, height: textStringSize.height)
            attributedText.draw(in: textStringRect)
            return textStringRect.origin.y + textStringRect.size.height
            
        }
    }
    
    func addParagraphText(pageRect: CGRect, textTop: CGFloat, text: String, context: UIGraphicsPDFRendererContext) -> CGFloat {
        let textFont = UIFont.systemFont(ofSize: 9.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font:textFont]
        let attributedText = NSAttributedString(string: text, attributes: textAttributes)
        if (textTop + attributedText.size().height) > 830{
            context.beginPage()
            let bottomSpace: CGFloat = 35.0
            let textRect = CGRect(x: 10, y: bottomSpace, width: pageRect.width - 40, height: attributedText.size().height)
            attributedText.draw(in: textRect)
            return textRect.origin.y + textRect.size.height
        }
        else{
            let textRect = CGRect(x: 10, y: textTop+5, width: pageRect.width - 20, height: attributedText.size().height)
            attributedText.draw(in: textRect)
            return textRect.origin.y + textRect.size.height
        }
    }
    
    func addHeading(pageRect: CGRect, textTop: CGFloat, text: String, context: UIGraphicsPDFRendererContext) -> CGFloat{
        
        let textFont = UIFont.systemFont(ofSize: 15, weight: .bold)
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: textFont]
        let attributedText = NSAttributedString(string: text, attributes: textAttributes)
        let textStringSize = attributedText.size()
        if (textTop + textStringSize.height) > 830 {
            context.beginPage()
            let bottomSpace: CGFloat = 35.0
            let textStringRect = CGRect(x: 10, y: bottomSpace, width: textStringSize.width, height: textStringSize.height)
            attributedText.draw(in: textStringRect)
            
            return textStringRect.origin.y + textStringRect.size.height
        }
        else{
            let textStringRect = CGRect(x: 10, y: textTop+20, width: textStringSize.width, height: textStringSize.height)
            attributedText.draw(in: textStringRect)
            
            return textStringRect.origin.y + textStringRect.size.height
        }
    }
    
    func bulletPointText(pageRect: CGRect, textTop: CGFloat, text: String, context: UIGraphicsPDFRendererContext) -> CGFloat {
        
        let textFont = UIFont.systemFont(ofSize: 9.0)
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: textFont]
        let attributedText = NSAttributedString(string: " \u{2022} \(text)", attributes: textAttributes)
        let textStringSize = attributedText.size()
        if (textTop + textStringSize.height) > 830 {
            context.beginPage()
            let bottomSpace: CGFloat = 35.0
            let textStringRect = CGRect(x: 20, y: bottomSpace, width: textStringSize.width, height: textStringSize.height)
            attributedText.draw(in: textStringRect)
            
            return textStringRect.origin.y + textStringRect.size.height
        }
        else
        {
            let textStringRect = CGRect(x: 20, y: textTop+10, width: textStringSize.width, height: textStringSize.height)
            attributedText.draw(in: textStringRect)
            
            return textStringRect.origin.y + textStringRect.size.height
        }
    }
    
    func addSubHeading(pageRect: CGRect, textTop: CGFloat, text: String, context: UIGraphicsPDFRendererContext)-> CGFloat {
        
        let textFont = UIFont.systemFont(ofSize: 11.0, weight: .bold)
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: textFont]
        let attributedText = NSAttributedString(string: text, attributes: textAttributes)
        let textStringSize = attributedText.size()
        
        if (textTop + textStringSize.height) > 830 {
            context.beginPage()
            let bottomSpace: CGFloat = 35.0
            let textStringRect = CGRect(x: 10, y: bottomSpace, width: textStringSize.width, height: textStringSize.height)
            attributedText.draw(in: textStringRect)
            
            return textStringRect.origin.y + textStringRect.size.height
        }
        else
        {        let textStringRect = CGRect(x: 10, y: textTop+10, width: textStringSize.width, height: textStringSize.height)
            attributedText.draw(in: textStringRect)
            
            return textStringRect.origin.y + textStringRect.size.height}
    }
    
    func addDate(pageRect: CGRect, textTop: CGFloat, text: String){
        
        let textFont = UIFont.systemFont(ofSize: 11.0)
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: textFont]
        let attributedText = NSAttributedString(string: text, attributes: textAttributes)
        let textStringSize = attributedText.size()
        let textStringRect = CGRect(x: pageRect.width - textStringSize.width - 10, y: textTop+10, width: textStringSize.width, height: textStringSize.height)
        attributedText.draw(in: textStringRect)
    }
}
