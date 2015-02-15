//
//  TriangleView.swift
//  carzapp
//
//  Created by вадим on 15.02.15.
//  Copyright (c) 2015 VK. All rights reserved.
//

import UIKit

class TriangleView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func drawRect(rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext();
            
        CGContextBeginPath(ctx);
        CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextClosePath(ctx);
        
        CGContextSetRGBFillColor(ctx, 0xa5/255.0, 0xa6/255.0, 0xaa/255.0, 1);
        CGContextFillPath(ctx);
        
    }
    

}
