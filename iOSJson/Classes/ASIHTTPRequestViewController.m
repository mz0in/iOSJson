//
//  ASIHTTPRequestViewController.m
//  iOSJson
//
//  Created by Pablo Eduardo Ojeda Vasco on 25/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import "ASIHTTPRequestViewController.h"
#import "Person.h"

@interface ASIHTTPRequestViewController ()

@end

@implementation ASIHTTPRequestViewController

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
    
    myTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myTable];
    
    
    // Create the conection
    NSURL *url = [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"];
    requestConnection = [ASIFormDataRequest requestWithURL:url];
    [requestConnection setRequestMethod:@"GET"];
    
    // Time of conection
    [requestConnection setTimeOutSeconds:10.0f];
    [requestConnection setDelegate:self];
    [requestConnection startAsynchronous];
}

#pragma mark -
#pragma mark - ASIHTTP
#pragma mark -
//Metodo que recibe la respuesta si todo ha ido bien
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
#if DEBUG
    NSLog(@"request status: %d",[request responseStatusCode]);
#endif
    // Check the server request
    switch ([request responseStatusCode])
    {
        // Success
        case 200:
        {
#if DEBUG
            NSLog(@"request 200: %@",[request responseString]);
#endif
            // Start parser
            JSONDecoder *jsonDecoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionValidFlags];
            
            //Parseo el data y obtenemos el resultado en un diccionario
            NSDictionary *dict = [jsonDecoder objectWithData:[request responseData]];
            
            // Starting JSON Parser
            // NSLog(@"---> dic: %@",dict);
            if ([dict objectForKey:@"loans"]!=[NSNull null])
            {
                // Initialize Person Array
                arrayPerson=[[NSMutableArray alloc]initWithCapacity:0];
                
                // Loop throw every block we find in the JSON
                for (NSDictionary *dictPerson in [dict objectForKey:@"loans"])
                {
                    // Create person Array
                    Person *persona=[[Person alloc]initPerson];
                    
                    if ([dictPerson objectForKey:@"id"] != nil)
                        [persona setID:[dictPerson objectForKey:@"id"]];
                    
                    if ([dictPerson objectForKey:@"name"] != nil)
                        [persona setName:[dictPerson objectForKey:@"name"]];
                    
                    if ([dictPerson objectForKey:@"sector"] != nil)
                        [persona setSector:[dictPerson objectForKey:@"sector"]];
                    
                    if ([dictPerson objectForKey:@"asd"] != nil)
                        [persona setActivity:[dictPerson objectForKey:@"activity"]];
                    
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
            [myTable reloadData];
        }
            break;
            
        default:
        {
            
            NSLog(@"Error en la conexion: %@",[request responseString]);
        }
            
            break;
    }
}

//Metodo que recoge la respuesta cuando ha fallado
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"request Error: %@",[request responseString]);
}

#pragma mark -
#pragma mark - Table view data source
#pragma mark -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    // Return the number of sections.
	NSInteger count = 1;
    
    return count;
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
    [cell.textLabel setText:[[arrayPerson objectAtIndex:indexPath.row] name]];
    [cell.detailTextLabel setText:[[arrayPerson objectAtIndex:indexPath.row] country]];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
