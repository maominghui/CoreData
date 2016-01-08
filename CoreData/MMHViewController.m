//
//  MMHViewController.m
//  CoreData
//
//  Created by 茆明辉 on 16/1/7.
//  Copyright © 2016年 com.mmh. All rights reserved.
//

#import "MMHViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Video.h"

@interface MMHViewController ()

@end

@implementation MMHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.video) {
        self.idField.text = [NSString stringWithFormat:@"%@",self.video.videoId];
        self.nameField.text = self.video.name;
        self.sizeField.text = [NSString stringWithFormat:@"%@",self.video.size];
        self.urlField.text = self.video.url;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveHandler:(id)sender {
    
    if (self.video) {
        [self edit];
    }else{
        //增加
        [self insert];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//修改
-(void)edit
{
    //修改
    //查询使用的类
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //需要查询的类
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Video" inManagedObjectContext:([self managedObjectContext])];
    
    NSString *string = [NSString stringWithFormat:@"videoId = %@",self.video.videoId];
    //创建查询条件的谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:string];
    
    //把查询的表传递给request
    [request setEntity:entity];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    //执行查询
    NSArray *array = [[self managedObjectContext] executeFetchRequest:request error:&error];
    
    if ([array count] > 0) {
        Video *v = array[0];
        v.name = self.nameField.text;
        v.size = [NSNumber numberWithInteger:[self.sizeField.text   integerValue]];
        v.url = self.urlField.text;
        
        //保存
        [[self managedObjectContext]save:&error];
    }
    
    if (error) {
        NSLog(@"%@",error);
    }
}

//增加
-(void)insert
{
    //创建一个需要增加的类
    Video *video = [NSEntityDescription insertNewObjectForEntityForName:@"Video" inManagedObjectContext:[self managedObjectContext]];
    video.videoId = [NSNumber numberWithInteger:[self.idField.text integerValue]];
    video.name = self.nameField.text;
    video.size = [NSNumber numberWithInteger:[self.idField.text integerValue]];
    video.url = self.urlField.text;
    
    NSError *error = nil;
    [[self managedObjectContext]save:&error];
    
    if (error) {
        NSLog(@"Save %@",error);
    }
}

-(NSManagedObjectContext *)managedObjectContext
{
    AppDelegate *delegete = [UIApplication sharedApplication].delegate;
    return delegete.managedObjectContext;
}

@end
