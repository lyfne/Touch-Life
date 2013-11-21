//
//  TLNoteViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-12.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLNoteViewController.h"
#import "UIView+FadeInOut.h"

@interface TLNoteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end

@implementation TLNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self initKeyboard];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initNavigationView];
    [self initNoteActionView];
    [self initNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Init Method

- (void)initNavigationView
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLNavigationViewController];
    self.navigationVC.delegate = self;
    [self.navigationVC.view setX:0 Y:0];
    [self.navigationVC.view setHeight:50];
    [self.navigationVC setActionButtonTitle:@"完成"];
    [self.navigationVC setHeaderTitle:@"新建日记"];
    [self.view addSubview:self.navigationVC.view];
}

- (void)initNoteActionView
{
    self.noteActionVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLNoteActionViewController];
    self.noteActionVC.delegate = self;
    [self.noteActionVC.view setX:0 Y:300];
    [self.noteActionVC.view setHeight:50];
    [self.view addSubview:self.noteActionVC.view];
}

- (void)initKeyboard
{
    [self.noteTextView becomeFirstResponder];
}

- (void)initView
{
    self.view.clipsToBounds = YES;
    takePhoto = NO;
}

- (void)initNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark Privite Method

- (void) keyboardDidShow:(NSNotification *) notif{
    [self.navigationVC setActionButtonTitle:@"完成"];
    keyboardWasShown = YES;
}

- (void) keyboardDidHide:(NSNotification *) notif{
    [self.navigationVC setActionButtonTitle:@"保存"];
    keyboardWasShown = NO;
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"0");
    }else if(buttonIndex == 1){
        TLNote *note = [TLNote createNoteWithDate:[NSDate date] note:self.noteTextView.text];
    }
}
                    
#pragma mark TLNavigationDelegate

- (void)moreAction
{
    if (keyboardWasShown) {
        [self.noteTextView resignFirstResponder];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"保存" message:@"确定保存？保存后将不可更改" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark TLNoteActionDelegate

- (void)takePhoto
{
    if (takePhoto == NO) {
        UIActionSheet *sheet;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        }else {
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        }
        sheet.tag = 255;
        [sheet showInView:self.view];
    }else{
        self.photoVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLPhotoViewController];
        [self.photoVC.view setX:0 Y:0 Width:self.view.frame.size.width Height:290];
        self.photoVC.delegate = self;
        [self.view addSubview:self.photoVC.view];
        [self.photoVC.view fadeIn:0.5f];
        [self performSelector:@selector(showDetailView:) withObject:savedImage afterDelay:0.5f];
    }
}

- (void)showDetailView:(UIImage *)image
{
    [self.photoVC addDetailViewWithImage:savedImage];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    return;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }else {
            if (buttonIndex == 0) {
                return;
            }else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    [self.noteActionVC setPhotoButtonTitle:@"查看"];
    takePhoto = YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)startRecord
{
    [self.noteTextView resignFirstResponder];
    self.recordVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLRecordViewController];
    self.recordVC.delegate = self;
    [self.recordVC.view setX:0 Y:0 Width:self.view.frame.size.width Height:self.view.frame.size.height];
    [self.view addSubview:self.recordVC.view];
    [self.recordVC.view fadeIn:0.5f];
    [self.recordVC startRecording];
}

#pragma mark TLRecoreDelegate

- (void)saveRecord
{
    
}

- (void)backToNoteView
{
    [self.recordVC.view fadeOut:0.5f];
    [self performSelector:@selector(removeRecordView) withObject:nil afterDelay:0.5f];
}

- (void)removeRecordView
{
    [self.noteTextView becomeFirstResponder];
    [self.recordVC.view removeFromSuperview];
}

#pragma mark TLPhotoDelegate

- (void)closePhotoView
{
    [self.photoVC.view fadeOut:0.5f];
    [self performSelector:@selector(removePhotoView) withObject:nil afterDelay:0.5f];
}

- (void)removePhotoView
{
    [self.photoVC.view removeFromSuperview];
}






-(void)textFieldDidBeginEditing:(UITextView *)textView
{
    CGRect frame = textView.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}
//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextView *)textView
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


@end
