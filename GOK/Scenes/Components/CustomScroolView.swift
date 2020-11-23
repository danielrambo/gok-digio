//
//  CustomScroolView.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import UIKit

public final class CustomScroolView: UIScrollView {

    public enum Effect {
        case undefined, fade
    }

    // MARK: - Init

    public init() {
        super.init(frame: .zero)

        self.delegate = self
    }

    public required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Properties

    private var scrollDirection: NSLayoutConstraint.Axis?
    private var pageSize: CGFloat?
    private var selectedEffect: Effect = .undefined
    private var observeChangePageIndexClosure: ((Int) -> Void)?
    private var currentPageIndex: Int = 0
    private var callChangePageIndexObserver: Bool = true
}

// MARK: - Overrides

extension CustomScroolView {
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: - Methods

public extension CustomScroolView {
    func set(scrollDirection: NSLayoutConstraint.Axis?) {
        self.scrollDirection = scrollDirection
    }

    func setEffectOnScroll(_ effect: Effect) {
        self.selectedEffect = effect
    }

    func observeChangePageIndex(closure: @escaping (Int) -> Void) {
        self.observeChangePageIndexClosure = closure
    }
}

// MARK: - Private

private extension CustomScroolView {
    func handleDirectionLock() {
        guard let scrollDirection = scrollDirection else { return }
        switch scrollDirection {
        case .horizontal:
            contentOffset.y = 0.0
        case .vertical:
            contentOffset.x = 0.0
        @unknown default:
            break
        }
    }

    func startEffect(_ scroll: UIScrollView) {
        switch selectedEffect {
        case .fade:
            for subview in self.subviews where subview.alpha > 0.7 {
                subview.alpha -= 0.01
            }
        default:
            break
        }
    }

    func endEffect(_ scroll: UIScrollView) {
        switch selectedEffect {
        case .fade:
            for subview in self.subviews {
                subview.alpha = 1.0
            }
        default:
            break
        }
    }
}

// MARK: - UIScrollView Delegate

extension CustomScroolView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        handleDirectionLock()
        startEffect(scrollView)
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        endEffect(scrollView)
    }
}
