//
//  MMHViewController.h
//  CoreData
//
//  Created by 茆明辉 on 16/1/7.
//  Copyright © 2016年 com.mmh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Video;
@interface MMHViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *idField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *sizeField;
@property (weak, nonatomic) IBOutlet UITextField *urlField;
- (IBAction)saveHandler:(id)sender;

@property (nonatomic, retain) Video *video;
@end
