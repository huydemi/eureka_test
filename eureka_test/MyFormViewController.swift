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
    
    form8()
  }
  
  private func testGetValues() {
    // Get the value of all rows which have a Tag assigned
    // The dictionary contains the 'rowTag':value pairs.
    let valuesDictionary = form.values()
    print(valuesDictionary)
  }
  
  private func form8() {
    form
      +++ Section(header: "Required Rule", footer: "Options: Validates on change")
      
      <<< TextRow() {
        $0.title = "Required Rule"
        $0.add(rule: RuleRequired())
        
        // This could also have been achieved using a closure that returns nil if valid, or a ValidationError otherwise.
        /*
         let ruleRequiredViaClosure = RuleClosure<String> { rowValue in
         return (rowValue == nil || rowValue!.isEmpty) ? ValidationError(msg: "Field required!") : nil
         }
         $0.add(rule: ruleRequiredViaClosure)
         */
        
        $0.validationOptions = .validatesOnChange
        }
        .cellUpdate { cell, row in
          if !row.isValid {
            cell.titleLabel?.textColor = .red
          }
        }
      
      +++ Section(header: "Email Rule, Required Rule", footer: "Options: Validates on change after blurred")
      
      <<< TextRow() {
        $0.title = "Email Rule"
        $0.add(rule: RuleRequired())
        $0.add(rule: RuleEmail())
        $0.validationOptions = .validatesOnChangeAfterBlurred
        }
        .cellUpdate { cell, row in
          if !row.isValid {
            cell.titleLabel?.textColor = .red
          }
        }
  }
  
  private func form7() {
    form +++
      MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                         header: "Multivalued TextField",
                         footer: ".Insert adds a 'Add Item' (Add New Tag) button row as last cell.") {
                          $0.addButtonProvider = { section in
                            return ButtonRow(){
                              $0.title = "Add New Tag"
                            }
                          }
                          $0.multivaluedRowToInsertAt = { index in
                            return NameRow() {
                              $0.placeholder = "Tag Name"
                            }
                          }
                          $0 <<< NameRow() {
                            $0.placeholder = "Tag Name"
                          }
      }
  }
  
  private func form6() {
    form +++ SelectableSection<ListCheckRow<String>>("Where do you live", selectionType: .singleSelection(enableDeselection: true))
    let continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
    for option in continents {
      form.last! <<< ListCheckRow<String>(option) { listRow in
        listRow.title = option
        listRow.selectableValue = option
        listRow.value = nil
      }
    }
  }
  
  private func form5() {
    form +++ Section()
      <<< SwitchRow("switchRowTag") {
        $0.title = "Show message"
      }
      <<< LabelRow() {
        $0.hidden = Condition.function(["switchRowTag"], { form in
          return !((form.rowBy(tag: "switchRowTag") as? SwitchRow)?.value ?? false)
        })
        $0.title = "Switch is on!"
      }
      
      +++ Section()
      <<< SwitchRow("switchTag") {
        $0.title = "hahaha"
      }
      
      <<< LabelRow() {
        $0.hidden = "$switchTag == false"
        $0.title = "Switch is on 2!"
      }
  }
  
  private func form4() {
    form +++ Section("Title")
      +++ Section(header: "Title", footer: "Footer Title")
      +++ Section(footer: "Footer Title")
      +++ Section() { section in
            var header = HeaderFooterView<EurekaLogoView>(.class)

            // Will be called every time the header appears on screen
            header.onSetupView = { view, _ in
              // Commonly used to setup texts inside the view
              // Don't change the view hierarchy or size here!
            }
            section.header = header
          }
      +++ Section() {
            $0.header = HeaderFooterView<EurekaLogoView>(.class)
          }
      +++ Section(){ section in
            section.header = {
              var header = HeaderFooterView<UIView>(.callback({
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                view.backgroundColor = .red
                return view
              }))
              header.height = { 100 }
              return header
            }()
          }
  }
  
  private func form3() {
    let row = SwitchRow("Switch Row") { row in // initializer
                row.title = "The title"
              }.onChange { row in
                row.title = (row.value ?? false) ? "The title expands when on" : "The title"
                row.updateCell()
              }.cellSetup { cell, row in
                cell.backgroundColor = .lightGray
              }.cellUpdate { cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 18.0)
              }
    
    form +++ Section("Section A")
      <<< row
  }
  
  private func form2() {
    // Append Sections into a Form
    form += [Section("A"), Section("B"), Section("C")]
    
    // Append Rows into a Section
    var section = Section()
    section += [TextRow(), DateRow()]
    
    form +++ Section()
      <<< TextRow()
      <<< DateRow()
    
    // Or implicitly create the Section
    form +++ TextRow()
      <<< DateRow()
    
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
