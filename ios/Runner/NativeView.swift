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

class NativeView: NSObject, FlutterPlatformView, NativeTextApi {

    private let _view: UIView
    private let _label: UILabel
    private var _flutterApi: FlutterTextApiHandler
    private let _pigeonMessenger: PigeonMultiInstanceBinaryMessengerWrapper

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        _view.frame = frame
        _label = UILabel(frame: _view.bounds)

        //setup pigeon
        _pigeonMessenger = PigeonMultiInstanceBinaryMessengerWrapper(with: messenger!, channelSuffix: "id_\(viewId)")
        _flutterApi = FlutterTextApiHandler(binaryMessenger: _pigeonMessenger)
        super.init()

        // setup views
        _view.backgroundColor = UIColor.cyan

        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        _label.textAlignment = .center
        
        _label.text = "NativeView_\(viewId)"

        _view.addSubview(_label)
        
        NativeTextApiSetup.setUp(binaryMessenger: _pigeonMessenger, api: self)
    }


    func view() -> UIView {
        return _view
    }
    
    func setText(text: String) throws {
        let finalText = "NativeView_\(text)"
        _label.text = finalText
        _flutterApi.textChanged(text: finalText, completion: {})
    }

}
