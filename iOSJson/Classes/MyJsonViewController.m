//
//  MyJsonViewController.m
//  iOSJson
//
//  Created by Pablo Eduardo Ojeda Vasco on 21/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import "MyJsonViewController.h"
#import "Person.h"

@interface MyJsonViewController ()

@end

@implementation MyJsonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // myTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    myTable=[[UITableView alloc]initWithFrame:CGRectMake(0, self.btnAdd.frame.origin.y+self.btnAdd.frame.size.height+10, self.view.frame.size.width, self.view.frame.size.height-self.btnAdd.frame.origin.y-self.btnAdd.frame.size.height-20) style:UITableViewStylePlain];
    
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myTable];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"persons" ofType:@"json"];
    
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    if (!myJSON) {
        NSLog(@"File couldn't be read!");
        return;
    }
    else
    {
        NSMutableData *JSONData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
        // Starting JSON Parser
        //NSLog(@"---> dic: %@",dict);
        if ([jsonDictionary objectForKey:@"persons"]!=[NSNull null])
        {
            // Initialize Person Array
            arrayPerson=[[NSMutableArray alloc]initWithCapacity:0];
            
            // Loop throw every block we find in the JSON
            for (NSDictionary *dictPerson in [jsonDictionary objectForKey:@"persons"])
            {
                // Create person Array
                Person *persona=[[Person alloc]initPerson];
                
                if ([dictPerson objectForKey:@"id"] != nil)
                    [persona setID:[dictPerson objectForKey:@"id"]];
                
                if ([dictPerson objectForKey:@"name"] != nil)
                    [persona setName:[dictPerson objectForKey:@"name"]];
                
                if ([dictPerson objectForKey:@"sector"] != nil)
                    [persona setSector:[dictPerson objectForKey:@"sector"]];
                
                if ([dictPerson objectForKey:@"location"] != nil)
                {
                    NSDictionary *dictLocation = [dictPerson objectForKey:@"location"];
                    if ([dictLocation objectForKey:@"country"] != nil) {
                        [persona setCountry:[dictLocation objectForKey:@"country"]];
                    }
                }
                
                [arrayPerson addObject:persona];
                NSLog(@"name: %@, activity: %@, country: %@", persona.name, persona.activity, persona.country);
            }
        }
        if (arrayPerson != nil) {
            [myTable reloadData];
            
        }
    }
    
}
- (IBAction)pushPerson:(id)sender {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"persons" ofType:@"json"];
    NSDictionary *dict = @{ @"persons" @"key" : @"value" };
    
    NSOutputStream *os = [[NSOutputStream alloc] initToFileAtPath:filePath append:YES];
    
    [os open];
    [NSJSONSerialization writeJSONObject:dict toStream:os options:0 error:nil];
    [os close];
    
    // reading back in...
    NSInputStream *is = [[NSInputStream alloc] initWithFileAtPath:filePath];
    
    [is open];
    NSDictionary *readDict = [NSJSONSerialization JSONObjectWithStream:is options:0 error:nil];
    [is close];
    
    NSLog(@"%@", readDict);
}

#pragma mark -
#pragma mark - Table view data source
#pragma mark -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger count=[arrayPerson count];
    
    if(count==0)
        count++;
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CellIdentifier";
	//creamos la celda
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
	{
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    if (arrayPerson == nil || [arrayPerson count] == 0) {
        [cell.textLabel setText:@"No hay datos"];
    }
    else
    {
        [cell.textLabel setText:[[arrayPerson objectAtIndex:indexPath.row] name]];
        [cell.detailTextLabel setText:[[arrayPerson objectAtIndex:indexPath.row] country]];
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
