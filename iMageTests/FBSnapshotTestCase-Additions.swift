//
//  FBSnapshotTestCase-Additions.swift
//  iMage
//
//  Created by Radu Costea on 5/9/17.
//  Copyright © 2017 cristik. All rights reserved.
//

import UIKit
import FBSnapshotTestCase.Swift

extension FBSnapshotTestCase {
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - preferredWidth: <#preferredWidth description#>
    ///   - padding: <#padding description#>
    /// - Throws: <#throws value description#>
    func verifyView(_ view: UIView, preferredWidth: CGFloat, padding: UIEdgeInsets = .zero) {
        let viewToVerify: UIView
        let size = view.systemLayoutSizeFitting(CGSize(width: preferredWidth, height: 0.0),
                                                withHorizontalFittingPriority: UILayoutPriorityRequired,
                                                verticalFittingPriority: UILayoutPriorityFittingSizeLevel)
        view.frame = CGRect(origin: CGPoint(x: padding.left, y: padding.top), size: size)
        
        if padding == .zero {
            viewToVerify = UIView()
            viewToVerify.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
            viewToVerify.frame = CGRect(origin: .zero, size: CGSize(width: size.width + padding.left + padding.right, height: size.height + padding.top + padding.bottom))
            viewToVerify.addSubview(view)
        } else {
            viewToVerify = view
        }
        
        FBSnapshotVerifyView(viewToVerify)
    }
}

extension UINib {
    static func load<T>(from nibName: String, bundle: Bundle? = nil) -> T! {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: [:]).first! as! T
    }
}
