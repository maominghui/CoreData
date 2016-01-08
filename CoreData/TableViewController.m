//
//  TableViewController.m
//  CoreData
//
//  Created by 茆明辉 on 16/1/7.
//  Copyright © 2016年 com.mmh. All rights reserved.
//

#import "TableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Video.h"
#import "MMHViewController.h"


@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"ASD");
    [self query];
}

-(void)query
{
    //查询使用的类
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //需要查询的类
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Video" inManagedObjectContext:([self managedObjectContext])];
    //创建排序类，ascending是升序
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"videoId" ascending:YES];
    //把查询的表传递给request
    [request setEntity:entity];
    //把排序的字段传给request
    [request setSortDescriptors:@[sort]];
    
    
    
    NSError *error = nil;
    //执行查询
    _array = [[self managedObjectContext] executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
    
    
}

-(NSManagedObjectContext *)managedObjectContext
{
    AppDelegate *delegete = [UIApplication sharedApplication].delegate;
    return delegete.managedObjectContext;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Video *video = _array[indexPath.row];
    cell.textLabel.text = video.name;
    cell.detailTextLabel.text = video.url;
    cell.detailTextLabel.textColor = [UIColor redColor];
    return cell;
}

//SB页面中的跳转
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"edit"]) {
        MMHViewController *vc = segue.destinationViewController;
        
        //通过单元格，得到indexPath
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Video *video = _array[indexPath.row];
        //当前行数据，传到第二个视图控制器
        vc.video = video;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self query];
    [self.tableView reloadData];
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        //获取当前行数据
        Video *v = _array[indexPath.row];
        
        //查询使用的类
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        //需要查询的类
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Video" inManagedObjectContext:([self managedObjectContext])];
        
        NSString *string = [NSString stringWithFormat:@"videoId = %@",v.videoId];
        //创建查询条件的谓词
        NSPredicate *predicate = [NSPredicate predicateWithFormat:string];
        
        //把查询的表传递给request
        [request setEntity:entity];
        [request setPredicate:predicate];
        
        NSError *error = nil;
        //执行查询
        NSArray *array = [[self managedObjectContext] executeFetchRequest:request error:&error];
        
        if ([array count] > 0) {
            v = array[0];

            
            //删除
            [[self managedObjectContext]deleteObject:v];
            //如果没有这一句只是删除内存里的，重新运行还有
            [[self managedObjectContext]save:&error];
            //查询
            [self query];
            [self.tableView reloadData];
        }
    }
}



- (IBAction)editHander:(id)sender {
    //进入编辑模式
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}
@end
