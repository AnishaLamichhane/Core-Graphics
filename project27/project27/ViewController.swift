//
//  ViewController.swift
//  project27
//
//  Created by Anisha Lamichhane on 12/5/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawRectangle()
    }

    @IBAction func redraw(_ sender: Any) {
        currentDrawType += 1
        print(currentDrawType)
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        switch currentDrawType {
        case 0:
            drawRectangle()
            
        case 1:
            drawCircle()
            
        case 2:
            drawCheckerBoard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
//            awesome drawing code
            let rectagle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 10, dy: 10)
            ctx.cgContext.setFillColor(UIColor.green.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.addRect(rectagle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        imageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
//            awesome drawing code
            let rectagle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 10, dy: 10) // bring in by 10 points on by every edge
            ctx.cgContext.setFillColor(UIColor.green.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.addEllipse(in: rectagle) // only change in this addEllipse
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        imageView.image = image
    }
    
    func drawCheckerBoard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
//            now loop over 8 rows and 8 columns
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if(row + col) % 2 == 0{
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                        
                    }
                }
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            
        }
        imageView.image = image
//        you can actually make checkerboards using a Core Image filter – check out CICheckerboardGenerato
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            let rotations = 16
            let amount = Double.pi / Double(rotations) //this is a formula
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            ctx.cgContext.setStrokeColor((UIColor.black.cgColor))
            ctx.cgContext.strokePath() // this will draw all 16 rectangles in one pass
            
        }
        imageView.image = image

    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256) //again we are drawing from the center
            var first = true
            var length: CGFloat = 256
            for _ in 0 ..< 256 {  // the lines will be drawn 256 times.
                ctx.cgContext.rotate(by: .pi/2)
                
                if first{
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                }else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                length *= 0.99
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath() // draw all lines in one shot.
        }
        imageView.image = image

    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
           let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let atters: [NSAttributedString.Key: Any] = [
                .font:UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            let string = "Swift programming is not hard \n as you say. Its harder"
            let attributedString = NSAttributedString(string: string, attributes: atters)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
            
        }
        imageView.image = image
    }
}

