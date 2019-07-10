//
//  ChatViewController.m
//  ParseChat
//
//  Created by atalwar98 on 7/10/19.
//  Copyright © 2019 atalwar98. All rights reserved.
//

#import "ChatViewController.h"
#import "Parse/Parse.h"
#import "ChatCell.h"

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *chatView;
@property (weak, nonatomic) IBOutlet UITextField *parseText;
@property (strong, nonatomic) NSArray *chatArray;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.chatView.delegate = self;
    self.chatView.dataSource = self;
    
    [self fetchChats];
    [self onTimer];
    
}

- (void)fetchChats{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Message_fbu2019"];
    [query includeKey:@"user"];
    [query orderByDescending:@"createdAt"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.chatArray = posts;
            [self.chatView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}

- (IBAction)tapSend:(UIButton *)sender {
    
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_fbu2019"];
    // Use the name of your outlet to get the text the user typed
    chatMessage[@"text"] = self.parseText.text;
    chatMessage[@"user"] = PFUser.currentUser;
    
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The message was saved!");
            self.parseText.text = @"";
        } else {
            NSLog(@"Problem saving message: %@", error.localizedDescription);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatCell *chatCell = [self.chatView dequeueReusableCellWithIdentifier:@"ChatCell"];
    PFObject *chat = self.chatArray[indexPath.row];
    chatCell.chatLabel.text = chat[@"text"];
    PFUser *user = chat[@"user"];
    if(user != nil){
        // User found! update username label with username
        chatCell.chatUser.text = user.username;
    } else {
        // No user found, set default username
        chatCell.chatUser.text = @"🤖";
    }
    return chatCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.chatArray.count;
}

- (void)onTimer {
    // Add code to be run periodically
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    [self fetchChats];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
