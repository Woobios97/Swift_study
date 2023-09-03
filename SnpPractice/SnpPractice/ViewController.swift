//
//  ViewController.swift
//  SnpPractice
//
//  Created by 김우섭 on 2023/08/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 스크롤 뷰 생성
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        // 스크롤 뷰의 컨텐츠 뷰 생성
        let contentView = UIView()
        scrollView.addSubview(contentView)
        
        // 스크롤 뷰의 컨텐츠 뷰에 뷰들 추가
        var previousView: UIView?
        for i in 1...20 {
            let subview = UIView()
            subview.backgroundColor = UIColor(red: CGFloat(i) / 10.0, green: 0.5, blue: 0.8, alpha: 1.0)
            contentView.addSubview(subview)
            
            subview.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(70)
                
                if let previous = previousView {
                    make.top.equalTo(previous.snp.bottom)
                } else {
                    make.top.equalToSuperview()
                }
            }
            
            previousView = subview
        }
        
        // SnapKit을 사용하여 스크롤 뷰 및 컨텐츠 뷰의 제약 조건 설정
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
            make.bottom.equalTo(previousView?.snp.bottom ?? contentView.snp.bottom) // 가장 아래 뷰의 아래에 정렬
        }
        
        // scrollView의 contentSize 설정
        scrollView.layoutIfNeeded()
        scrollView.contentSize = contentView.bounds.size
    }
}

#if DEBUG
import SwiftUI

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif

#if DEBUG
import SwiftUI

struct VCPreView: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}
#endif
