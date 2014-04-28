//
//  WebVideoViewController.h
//  iOSJson
//
//  Created by Pablo Eduardo Ojeda Vasco on 21/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface WebVideoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *lbLoad;

@property (copy, nonatomic) NSURL *movieURL;
@property (strong, nonatomic) MPMoviePlayerController *movieController;

@end
