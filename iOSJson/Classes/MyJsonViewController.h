//
//  MyJsonViewController.h
//  iOSJson
//
//  Created by Pablo Eduardo Ojeda Vasco on 21/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyJsonViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *myTable;
    NSMutableArray *arrayPerson;
}
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@end
