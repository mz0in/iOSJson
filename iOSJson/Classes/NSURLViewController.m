//
//  NSURLViewController.m
//  iOSJson
//
//  Created by Pablo Eduardo Ojeda Vasco on 21/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import "NSURLViewController.h"
#import "Person.h"

@interface NSURLViewController ()

@end

@implementation NSURLViewController
@synthesize _responseData;
@synthesize _connection;

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
    
    
    // Create the request.
    NSURL *url = [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"];
    
    
    /* create the request */
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    /* create the connection */
    _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    /* ensure the connection was created */
    if (_connection)
    {
        /* initialize the buffer */
        _responseData = [NSMutableData data];
        
        /* start the request */
        [_connection start];
    }
    else
    {
        NSLog(@"Se ha producido un error en la conexion");
    }

}

#pragma mark NSURLConnection Delegate Methods
//Metodos para realizar la conexion
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    /* reset the buffer length each time this is called */
    [_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError *error = nil;
        
        //Muestra el json en formato NSString
        //        NSString *jsonString = [[NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&error] description];
        
        // Initializate JSON parser
        JSONDecoder *jsonDecoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionValidFlags];
        
        // Parsing Data and move data result into a dictionary
        NSDictionary *dict = [jsonDecoder objectWithData:_responseData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
                           
           /* check for a JSON error */
           if (!error)
           {
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
           else
           {
               NSLog(@"Connection failed! Error - %@ %@",[error localizedDescription],[[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
           }
           
           /* clear the connection &amp; the buffer */
           _connection = nil;
           _responseData  = nil;
       });
        
    });
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    /* clear the connection &amp; the buffer */
    _connection = nil;
    _responseData     = nil;
    
    NSLog(@"Connection failed! Error - %@ %@",[error localizedDescription],[[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
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
