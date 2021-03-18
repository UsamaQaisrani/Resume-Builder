//
//  ResumeCreator.swift
//  Resume Builder
//
//  Created by Usama on 17/03/2021.
//

import Foundation
import PDFKit

class ResumeCreator {
    
//MARK:- Class Properties
    
    static let shared = ResumeCreator()

    
//MARK:- Class Methods
    
    lazy var pageWidth : CGFloat  = {
        return 8.5 * 72.0
    }()

    lazy var pageHeight : CGFloat = {
        return 11 * 72.0
    }()

    lazy var pageRect : CGRect = {
        CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
    }()

    lazy var marginPoint : CGPoint = {
        return CGPoint(x: 10, y: 10)
    }()

    lazy var marginSize : CGSize = {
        return CGSize(width: self.marginPoint.x * 2 , height: self.marginPoint.y * 2)
    }()
    
    var lastGroup: (Int, CGFloat)?
    let contactInfo = AppManager.shared.resumeData.contactInfoData
    let coverLetterInfo = AppManager.shared.resumeData.coverLetterData
    let objectiveInfo = AppManager.shared.resumeData.objectiveData
    let qualificationInfo = AppManager.shared.resumeData.qualificationsData
    let workExperienceInfo = AppManager.shared.resumeData.workExperienceData
    let educationInfo = AppManager.shared.resumeData.educationData
    let referenceInfo = AppManager.shared.resumeData.referenceData

    func prepareData() -> Data {
        //1
        let pdfMetaData = [
          kCGPDFContextCreator: "PDF Creator",
          kCGPDFContextAuthor: "Pratik Sodha",
          kCGPDFContextTitle: "My PDF"
        ]

        //2
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        //3
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        //5
        let data = renderer.pdfData { (context) in

            //6
            context.beginPage()
            self.addText(text: contactInfo?.address ?? "Address : ", font: .systemFont(ofSize: 9.0), context: context, currentPage: 0)
            self.addText(text: contactInfo?.phoneNumber ?? "Phone Number : ", font: .systemFont(ofSize: 9.0), context: context, currentPage: 0)
        }

        return data
    }

    func addText( text: String,
                   font: UIFont,
                   context: UIGraphicsPDFRendererContext,
                   currentPage: Int,
                   lastPosition: CGFloat = 0) -> (Int, CGFloat) {
        // ...
        var lastPosition = lastPosition
        let textAttributes = [
            NSAttributedString.Key.font: font
        ]
        var newPosition: CGFloat = 0
        let currentText = CFAttributedStringCreate(nil,
                                                      text as CFString,
                                                      textAttributes as CFDictionary)
        var currentRange = CFRangeMake(0, 0)
        let framesetter = CTFramesetterCreateWithAttributedString(currentText!)
        var done = false
        repeat {
            let textRect = CTFramesetterSuggestFrameSizeWithConstraints(
                framesetter, currentRange, nil,
                .init(
                    width: self.pageWidth - self.marginSize.width,
                    height: self.pageHeight - self.marginSize.height - lastPosition
                    ),
                nil
                )

            currentRange = renderPage(2, withTextRange: currentRange, andFramesetter: framesetter, from: lastPosition)

            // MARK: - Changes2: reset after first drawing
            lastPosition = 0
            // MARK: - save the newPosition
            newPosition = textRect.height > newPosition ? textRect.height : newPosition
            /* If we're at the end of the text, exit the loop. */
            if currentRange.location == CFAttributedStringGetLength(currentText) {
                done = true
            }
        } while !done

        return (currentPage, newPosition)
    }
    
    func renderPage(_ pageNum: Int, withTextRange currentRange: CFRange, andFramesetter framesetter: CTFramesetter?, from lastPosition: CGFloat = 0) -> CFRange {
        var currentRange = currentRange
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.textMatrix = .identity

        // MARK: - Chanages1: Resize rect based on the last ending point
        let frameRect = CGRect(
            x: self.marginPoint.x,
            y: self.marginPoint.y + lastPosition,
            width: self.pageWidth - self.marginSize.width,
            height: self.pageHeight - self.marginSize.height - lastPosition
            )

        let framePath = CGMutablePath()
        framePath.addRect(frameRect)
        let frameRef = CTFramesetterCreateFrame(framesetter!, currentRange, framePath, nil)

        // MARK: - Changes2
        if lastPosition == 0 {
            currentContext?.translateBy(x: 0, y: self.pageHeight)

            currentContext?.scaleBy(x: 1.0, y: -1.0)
        } else {
            // MARK: - Already in the context, no need to "mirror"
            currentContext?.translateBy(x: 0, y: -lastPosition)
        }
        CTFrameDraw(frameRef, currentContext!)
        currentRange = CTFrameGetVisibleStringRange(frameRef)
        currentRange.location += currentRange.length
        currentRange.length = CFIndex(0)

        return currentRange
    }

    func drawPageNumber(_ pageNum: Int) {

        let theFont = UIFont.systemFont(ofSize: 20)

        let pageString = NSMutableAttributedString(string: "Page \(pageNum)")
        pageString.addAttribute(NSAttributedString.Key.font, value: theFont, range: NSRange(location: 0, length: pageString.length))

        let pageStringSize =  pageString.size()

        let stringRect = CGRect(x: (pageRect.width - pageStringSize.width) / 2.0,
                                y: pageRect.height - (pageStringSize.height) / 2.0 - 15,
                                width: pageStringSize.width,
                                height: pageStringSize.height)

        pageString.draw(in: stringRect)

    }
    }
    

