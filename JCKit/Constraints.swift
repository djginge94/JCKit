//
//  Constraints.swift
//  JCComponents
//
//  Created by Joshua Colley on 28/03/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import UIKit

public protocol LayoutAnchor: NSObjectProtocol {
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}
private protocol LayoutDimension: LayoutAnchor {
    func constraint(equalToConstant c: CGFloat) -> NSLayoutConstraint
}
extension NSLayoutAnchor: LayoutAnchor {}
extension NSLayoutDimension: LayoutDimension {}

public struct LayoutProperty<Anchor: LayoutAnchor> {
    fileprivate let anchor: Anchor
}
extension LayoutProperty {
    func equal(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) {
        anchor.constraint(equalTo: otherAnchor, constant: constant).isActive = true
    }
    func equal(to constant: CGFloat) {
        if let anchor = anchor as? NSLayoutDimension {
            anchor.constraint(equalToConstant: constant).isActive = true
        }
    }
    func greaterThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) {
        anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant).isActive = true
    }
    func lessThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) {
        anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant).isActive = true
    }
}

public class LayoutProxy {
    public lazy var leading = property(with: view.leadingAnchor)
    public lazy var trailing = property(with: view.trailingAnchor)
    public lazy var top = property(with: view.topAnchor)
    public lazy var bottom = property(with: view.bottomAnchor)
    public lazy var width = property(with: view.widthAnchor)
    public lazy var height = property(with: view.heightAnchor)
    public lazy var centerX = property(with: view.centerXAnchor)
    public lazy var centerY = property(with: view.centerYAnchor)
    
    private let view: UIView
    
    fileprivate init(view: UIView) { self.view = view }
    private func property<A: LayoutAnchor>(with anchor: A) -> LayoutProperty<A> {
        return LayoutProperty(anchor: anchor)
    }
}

extension UIView {
    public func layout(using closure: (LayoutProxy) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }
}

public func +<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, rhs)
}

public func -<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, -rhs)
}
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A , CGFloat) ) {
    lhs.equal(to: rhs.0, offsetBy: rhs.1)
}
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: CGFloat) {
    lhs.equal(to: rhs)
}
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) {
    lhs.equal(to: rhs)
}
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) {
    lhs.greaterThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) {
    lhs.greaterThanOrEqual(to: rhs)
}

public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) {
    lhs.lessThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) {
    lhs.lessThanOrEqual(to: rhs)
}
