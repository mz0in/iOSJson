//
//  ASIHTTPRequestViewController.h
//  iOSJson
//
//  Created by Pablo Eduardo Ojeda Vasco on 25/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@interface ASIHTTPRequestViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ASIHTTPRequestDelegate>
{
    UITableView *myTable;
    ASIFormDataRequest *requestConnection;    
    NSMutableArray *arrayPerson;
}

@end
