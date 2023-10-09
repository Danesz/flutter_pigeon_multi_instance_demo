//
//  NativeView.swift
//  Runner
//
//  Created by Daniel on 09/10/2023.
//

import Foundation
import Flutter
import UIKit
import SwiftUI

class NativeView: NSObject, FlutterPlatformView {

    private let _view: UIView
    private let _label: UILabel

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        _view.frame = frame
        _label = UILabel(frame: _view.bounds)

        super.init()

        // setup views
        _view.backgroundColor = UIColor.cyan

        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        _label.textAlignment = .center
        
        _label.text = "NativeView_\(viewId)"

        _view.addSubview(_label)
    }


    func view() -> UIView {
        return _view
    }

}
