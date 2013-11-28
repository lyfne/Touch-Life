//
//  TLNoteViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-12.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLNoteViewController.h"
#import "UIView+FadeInOut.h"
#import "FastTextView.h"

#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreText/CoreText.h>
#import "NSAttributedString+TextUtil.h"
#import "SlideAttachmentCell.h"
#import "EmotionAttachmentCell.h"
#import "UIImage-Extensions.h"


@interface TLNoteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end

@implementation TLNoteViewController
@synthesize fastTextView=_fastTextView;

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
    //[self initKeyboard];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //加上键盘工具
    UIToolbar *topViewToolBar =[[UIToolbar alloc]initWithFrame: CGRectMake(0, 0, 320, 30)];
    [topViewToolBar setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * pictureButton = [[UIBarButtonItem alloc]initWithTitle:@"Picture" style:UIBarButtonItemStyleBordered target:self action:@selector(PickPicture)];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:pictureButton,btnSpace,doneButton,nil];
    [topViewToolBar setItems:buttonsArray];
    
    
    
    
    
    if (_fastTextView==nil) {
        
        FastTextView *view = [[FastTextView alloc] initWithFrame:CGRectMake(0, 20+20, self.view.bounds.size.width, self.view.bounds.size.height-20)];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.delegate = (id<FastTextViewDelegate>)self;
        view.delegate = (id<FastTextViewDelegate>)self;
        view.placeHolder=@"章节内容";
        [view setFont:[UIFont systemFontOfSize:17]];
        view.pragraghSpaceHeight=15;
        view.backgroundColor=[UIColor clearColor];
        [self.view addSubview:view];
        self.fastTextView = view;
        NSString *default_txt = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"a.txt"];
        // #endif
        
    }
    
    [self.fastTextView setInputAccessoryView:topViewToolBar];
    
    
    [self initView];
    [self initNavigationView];
    [self initNoteActionView];
    [self initNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(IBAction)dismissKeyBoard
{
    [self.fastTextView resignFirstResponder];
    NSLog(@"内容是： %@",self.fastTextView.text);
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

- (IBAction)PickPicture    //photo
{
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
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
        isAddPicture = TRUE;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}


- (void)_addAttachmentFromAsset:(ALAsset *)asset;
{
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    NSMutableData *data = [NSMutableData dataWithLength:[rep size]];
    
    NSError *error = nil;
    if ([rep getBytes:[data mutableBytes] fromOffset:0 length:[rep size] error:&error] == 0) {
        NSLog(@"error getting asset data %@", [error debugDescription]);
    } else {
        //        NSFileWrapper *wrapper = [[NSFileWrapper alloc] initRegularFileWithContents:data];
        //        wrapper.filename = [[rep url] lastPathComponent];
        UIImage *img=[UIImage imageWithData:data];
        
        NSString *newfilename=[NSAttributedString scanAttachmentsForNewFileName:_fastTextView.attributedString];
        
        
        
        NSArray *_paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * _documentDirectory = [[NSString alloc] initWithString:[_paths objectAtIndex:0]];
        
        
        UIImage *thumbimg=img;
        
        NSString *pngPath=[_documentDirectory stringByAppendingPathComponent:newfilename];
        
        //[[AppDelegate documentDirectory] stringByAppendingPathComponent:@"tmp.jpg"];
        
        
        [UIImageJPEGRepresentation(thumbimg,0.7)writeToFile:pngPath atomically:YES];
        
        UITextRange *selectedTextRange = [_fastTextView selectedTextRange];
        if (!selectedTextRange) {
            UITextPosition *endOfDocument = [_fastTextView endOfDocument];
            selectedTextRange = [_fastTextView textRangeFromPosition:endOfDocument toPosition:endOfDocument];
        }
        UITextPosition *startPosition = [selectedTextRange start] ; // hold onto this since the edit will drop
        
        unichar attachmentCharacter = FastTextAttachmentCharacter;
        [_fastTextView replaceRange:selectedTextRange withText:[NSString stringWithFormat:@"\n%@\n",[NSString stringWithCharacters:&attachmentCharacter length:1]]];
        
        startPosition=[_fastTextView positionFromPosition:startPosition inDirection:UITextLayoutDirectionRight offset:1];
        UITextPosition *endPosition = [_fastTextView positionFromPosition:startPosition offset:1];
        selectedTextRange = [_fastTextView textRangeFromPosition:startPosition toPosition:endPosition];
        
        
        NSMutableAttributedString *mutableAttributedString=[_fastTextView.attributedString mutableCopy];
        
        NSUInteger st = ((FastIndexedPosition *)(selectedTextRange.start)).index;
        NSUInteger en = ((FastIndexedPosition *)(selectedTextRange.end)).index;
        
        if (en < st) {
            return;
        }
        NSUInteger contentLength = [[_fastTextView.attributedString string] length];
        if (en > contentLength) {
            en = contentLength; // but let's not crash
        }
        if (st > en)
            st = en;
        NSRange cr = [[_fastTextView.attributedString string] rangeOfComposedCharacterSequencesForRange:(NSRange){ st, en - st }];
        if (cr.location + cr.length > contentLength) {
            cr.length = ( contentLength - cr.location ); // but let's not crash
        }
        
        if(isAddPicture){
            
            FileWrapperObject *fileWp = [[FileWrapperObject alloc] init];
            [fileWp setFileName:newfilename];
            [fileWp setFilePath:pngPath];
            
            SlideAttachmentCell *cell = [[SlideAttachmentCell alloc] initWithFileWrapperObject:fileWp] ;
            //ImageAttachmentCell *cell = [[ImageAttachmentCell alloc] init];
            cell.isNeedThumb=TRUE;
            cell.thumbImageWidth=200.0f;
            cell.thumbImageHeight=200.0f;
            cell.txtdesc=@"Success";
            
            [mutableAttributedString addAttribute: FastTextAttachmentAttributeName value:cell  range:cr];
            
            //[mutableAttributedString addAttribute:fastTextAttachmentAttributeName value:cell  range:selectedTextRange];
            
            
        }else{
            //            ImageAttachmentCell *cell = [[ImageAttachmentCell alloc] initWithFileWrapper:wrapper] ;
            //            //ImageAttachmentCell *cell = [[ImageAttachmentCell alloc] init];
            //            cell.isNeedThumb=TRUE;
            //            cell.thumbImageWidth=200.0f;
            //            cell.thumbImageHeight=200.0f;
            //
            //            [mutableAttributedString addAttribute: fastTextAttachmentAttributeName value:cell  range:cr];
        }
        
        
        
        
        if (mutableAttributedString) {
            _fastTextView.attributedString = mutableAttributedString;
        }
        
        //[_editor setValue:attachment forAttribute:OAAttachmentAttributeName inRange:selectedTextRange];
        
        
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init] ;
    [library assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
             resultBlock:^(ALAsset *asset){
                 // This get called asynchronously (possibly after a permissions question to the user).
                 [self _addAttachmentFromAsset:asset];
             }
            failureBlock:^(NSError *error){
                NSLog(@"error finding asset %@", [error debugDescription]);
            }];
    [self dismissModalViewControllerAnimated:YES];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    takePhoto = YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)startRecord    //
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


#pragma mark -
#pragma mark fastTextViewDelegate

- (BOOL)fastTextViewShouldBeginEditing:(FastTextView *)textView {
    return YES;
}

- (BOOL)fastTextViewShouldEndEditing:(FastTextView *)textView {
    return YES;
}

- (void)fastTextViewDidBeginEditing:(FastTextView *)textView {
}

- (void)fastTextViewDidEndEditing:(FastTextView *)textView {
}

- (void)fastTextViewDidChange:(FastTextView *)textView {
    
}

- (void)fastTextView:(FastTextView*)textView didSelectURL:(NSURL *)URL {
    
}

@end
