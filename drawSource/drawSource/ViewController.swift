//
//  ViewController.swift
//  drawSource
//
//  Created by Devine Lu Linvega on 2014-08-14.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
		
	@IBOutlet var gridView: UIView!
	@IBOutlet var drawView: DrawView!
	
	@IBOutlet var optionClear: UIButton!
	
	@IBOutlet var modeGeometric: UIButton!
	@IBOutlet var modeMirror: UIButton!
	@IBOutlet var modeThick: UIButton!
	@IBOutlet var modeRounded: UIButton!
	@IBOutlet var modeColor: UIButton!
	@IBOutlet var modeContinuous: UIButton!
	
	@IBOutlet var interfaceModes: UIView!
	
	@IBOutlet var renderView: UIImageView!
	@IBOutlet var outputView: UIView!
	
	var tileSize:CGFloat!
	var screenWidth:CGFloat!
	var screenHeight:CGFloat!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		templateStart()
	
		modeMirrorToggle()
		modeThickToggle()
		modeGeometricToggle()
//		modeColorToggle()
		modeRoundedToggle()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func templateStart()
	{
		tileSize = self.view.frame.size.width/8
		screenWidth = self.view.frame.size.width
		screenHeight = self.view.frame.size.height
		
		var theDrawView = drawView as DrawView
		theDrawView.setUnit = tileSize
		
		theDrawView.setRenderView(renderView,targetOutputView: outputView)
		
		renderView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
		outputView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
		theDrawView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
		
		// Interfaces
		interfaceModes.frame = CGRectMake(0, screenHeight-tileSize, screenWidth, tileSize)
		
		// Options
		
		optionClear.frame = CGRectMake(screenWidth-(tileSize), 0, tileSize, tileSize)
		optionClear.backgroundColor = UIColor.redColor()
		optionClear.setTitle("Nu", forState: UIControlState.Normal)
		
		// Modes
		modeMirror.frame = CGRectMake(0, 0, tileSize, tileSize)
		modeMirror.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
		modeMirror.setTitle("Mi", forState: UIControlState.Normal)
		
		// Geometric
		modeGeometric.frame = CGRectMake(tileSize, 0, tileSize, tileSize)
		modeGeometric.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
		modeGeometric.setTitle("Sq", forState: UIControlState.Normal)
		
		// Thickness
		modeThick.frame = CGRectMake(tileSize*2, 0, tileSize, tileSize)
		modeThick.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
		modeThick.setTitle("Th", forState: UIControlState.Normal)
		
		// Roundess
		modeRounded.frame = CGRectMake(tileSize*3, 0, tileSize, tileSize)
		modeRounded.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
		modeRounded.setTitle("Rn", forState: UIControlState.Normal)
		
		// Color
		modeColor.frame = CGRectMake(tileSize*5, 0, tileSize, tileSize)
		modeColor.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
		modeColor.setTitle("Cb", forState: UIControlState.Normal)
			
		templateGrid()
	}
	
	func templateGrid()
	{
		var lineView = UIView(frame: CGRectMake(tileSize, tileSize, 1, screenHeight-(2*tileSize)))
		lineView.backgroundColor = UIColor.whiteColor()
		self.gridView.addSubview(lineView)
		
		lineView = UIView(frame: CGRectMake(screenWidth-tileSize, tileSize, 1, screenHeight-(2*tileSize)))
		lineView.backgroundColor = UIColor.whiteColor()
		self.gridView.addSubview(lineView)
		
		lineView = UIView(frame: CGRectMake(tileSize, tileSize, screenWidth-(2*tileSize), 1))
		lineView.backgroundColor = UIColor.whiteColor()
		self.gridView.addSubview(lineView)
		
		lineView = UIView(frame: CGRectMake(tileSize, screenHeight-tileSize, screenWidth-(2*tileSize), 1))
		lineView.backgroundColor = UIColor.whiteColor()
		self.gridView.addSubview(lineView)
		
		var x:CGFloat = 1
		while x < 18
		{
			var y:CGFloat = 1
			while y < 30
			{
				var posX:CGFloat =  CGFloat( Int( tileSize+(tileSize/2*x) ) )
				var posY:CGFloat =  CGFloat( Int( tileSize+(tileSize/2*y) ) )
				
				var lineView = UIView(frame: CGRectMake( posX, posY, 1, 1))
				lineView.backgroundColor = UIColor.whiteColor()
				self.gridView.addSubview(lineView)
				
				y = y + 1
			}
			
			x = x + 1
		}
	}
	
	@IBAction func optionClear(sender: AnyObject)
	{
		NSLog("> OPTI | Clear")
		var theDrawView = drawView as DrawView
		theDrawView.lines = []
		renderView.image = UIImage(named: "")
		theDrawView.setNeedsDisplay()
	}
	
	// Modes
	
	@IBAction func modeMirror(sender: AnyObject)
	{
		modeMirrorToggle()
	}
	
	func modeMirrorToggle()
	{
		var theDrawView = drawView as DrawView
		
		var modes = ["M","Mx","My","Mr"]
		var modesIndex = find(modes, theDrawView.modeMirror)!
		var modeTarget = modesIndex+1
		if modeTarget > modes.count-1{ modeTarget = 0	}
		theDrawView.modeMirror = modes[modeTarget]
		modeMirror.setTitle( String(format:"%@",modes[modeTarget]), forState: UIControlState.Normal)
	}
	
	// Color
	
	@IBAction func modeColor(sender: AnyObject)
	{
		modeColorToggle()
	}
	
	func modeColorToggle()
	{
		var theDrawView = drawView as DrawView
		
		var modes = ["Cb","Cw","Cy","Cr","Gg"]
		var modesIndex = find(modes, theDrawView.modeColor)!
		var modeTarget = modesIndex+1
		if modeTarget > modes.count-1{ modeTarget = 0	}
		theDrawView.modeColor = modes[modeTarget]
		modeColor.setTitle( String(format:"%@",modes[modeTarget]), forState: UIControlState.Normal)
		theDrawView.setNeedsDisplay()
	}
	
	// Geometric
	
	@IBAction func modeGeometric(sender: AnyObject)
	{
		modeGeometricToggle()
	}
	
	func modeGeometricToggle()
	{
		var theDrawView = drawView as DrawView
		
		var modes = ["Gf","Gs","Gp"]
		var modesIndex = find(modes, theDrawView.modeGeometric)!
		var modeTarget = modesIndex+1
		if modeTarget > modes.count-1{ modeTarget = 0	}
		theDrawView.modeGeometric = modes[modeTarget]
		modeGeometric.setTitle( String(format:"%@",modes[modeTarget]), forState: UIControlState.Normal)
	}
	
	// Thickness
	
	@IBAction func modeThick(sender: AnyObject)
	{
		modeThickToggle()
	}
	
	func modeThickToggle()
	{
		var theDrawView = drawView as DrawView
		
		var modes = ["T1","T2","T3","T4","Ta"]
		var modesIndex = find(modes, theDrawView.modeThick)!
		var modeTarget = modesIndex+1
		if modeTarget > modes.count-1{ modeTarget = 0	}
		theDrawView.modeThick = modes[modeTarget]
		modeThick.setTitle( String(format:"%@",modes[modeTarget]), forState: UIControlState.Normal)
	}
	
	@IBAction func modeRounded(sender: AnyObject)
	{
		modeRoundedToggle()
	}
	
	func modeRoundedToggle()
	{
		var theDrawView = drawView as DrawView
		
		var modes = ["Rr","Rs"]
		var modesIndex = find(modes, theDrawView.modeRounded)!
		var modeTarget = modesIndex+1
		if modeTarget > modes.count-1{ modeTarget = 0	}
		theDrawView.modeRounded = modes[modeTarget]
		modeRounded.setTitle( String(format:"%@",modes[modeTarget]), forState: UIControlState.Normal)
	}
	
	@IBAction func modeContinuous(sender: AnyObject) {
		
	}
	
	func test()
	{
	
	}
	
	// MARK: - Misc
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}

}

