//
//  NSURLViewController.h
//  iOSJson
//
//  Created by Pablo Eduardo Ojeda Vasco on 21/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"

@interface NSURLViewController : UIViewController <NSURLConnectionDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UITableView *myTable;    
    NSMutableArray *arrayPerson;
}

@property (nonatomic, strong) NSURLConnection *_connection;
@property (nonatomic, strong) NSMutableData *_responseData;


@end
