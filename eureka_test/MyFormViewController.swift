//
//  MyFormViewController.swift
//  eureka_test
//
//  Created by Dang Quoc Huy on 7/16/18.
//  Copyright © 2018 Dang Quoc Huy. All rights reserved.
//

import UIKit
import Eureka

class MyFormViewController: FormViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    form2()
  }
  
  private func testGetValues() {
    // Get the value of all rows which have a Tag assigned
    // The dictionary contains the 'rowTag':value pairs.
    let valuesDictionary = form.values()
    print(valuesDictionary)
  }
  
  private func form2() {
    form +++ Section()
    
    // Chain it to add multiple Sections
    form +++ Section("First Section") +++ Section("Another Section")
    
    // Or use it with rows and get a blank section for free
    form +++ TextRow()
         +++ TextRow()  // Each row will be on a separate section
  }
  
  private func form1() {
    form +++ Section("Session 1")
      <<< TextRow() { row in
        row.title = "Text Row"
        row.placeholder = "Enter text here"
        row.tag = "nameText"
      }
      <<< PhoneRow() {
        $0.title = "Phone Row"
        $0.placeholder = "Add number here"
        $0.tag = "phoneText"
      }
    +++ Section("Section 2")
      <<< LabelRow() {
        $0.title = "This is a label title"
        $0.value = "This is label value"
      }
      <<< LabelRow() {
        $0.title = "This is a label title"
        $0.value = "This is label value"
      }
      <<< LabelRow() {
        $0.title = "This is a label title"
        $0.value = "This is label value"
      }
      <<< LabelRow() {
        $0.title = "This is a label title"
        $0.value = "This is label value"
      }
      <<< LabelRow() {
        $0.title = "This is a label title"
        $0.value = "This is label value"
      }
      <<< LabelRow() {
        $0.title = "This is a label title"
        $0.value = "This is label value"
      }
      <<< LabelRow() {
        $0.title = "This is a label title"
        $0.value = "This is label value"
      }
      <<< LabelRow() {
        $0.title = "This is a label title"
        $0.value = "This is label value"
      }
      <<< LabelRow() {
        $0.title = "This is a label title"
        $0.value = "This is label value"
      }
      <<< LabelRow() {
        $0.title = "This is a label title"
        $0.value = "This is label value"
      }
      <<< DateRow() {
        $0.title = "Data Row"
        $0.value = Date(timeIntervalSinceReferenceDate: 0)
        $0.tag = "dateText"
      }
      
    +++ Section()
      <<< ButtonRow() { (row: ButtonRow) -> Void in
        row.title = "Get Values"
        }
        .onCellSelection { [weak self] (cell, row) in
          self?.testGetValues()
    }
    
    // Enables the navigation accessory and stops navigation when a disabled row is encountered
    //navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
    // Enables smooth scrolling on navigation to off-screen rows
    animateScroll = true
    // Leaves 60pt of space between the keyboard and the highlighted row after scrolling to an off screen row
    rowKeyboardSpacing = 60
  }
}
