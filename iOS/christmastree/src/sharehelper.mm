#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import <UIKit/UIWindow.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIActivityViewController.h>

#include <QtCore/QDir>

#include "sharehelper.h"

ShareHelper::ShareHelper(QObject *parent) : QObject(parent)
{
}

ShareHelper::~ShareHelper()
{
}

QString ShareHelper::imageFilePath() const
{
    return QDir(QString::fromNSString(NSTemporaryDirectory())).filePath("image.jpg");
}

void ShareHelper::showShareToView()
{
    UIImage                  *image                    = [UIImage imageWithContentsOfFile:imageFilePath().toNSString()];
    UIActivityViewController *activity_view_controller = [[UIActivityViewController alloc] initWithActivityItems:@[image] applicationActivities:nil];

    activity_view_controller.excludedActivityTypes = @[];

    UIViewController * __block root_view_controller = nil;

    [[[UIApplication sharedApplication] windows] enumerateObjectsUsingBlock:^(UIWindow * _Nonnull window, NSUInteger, BOOL * _Nonnull stop) {
        root_view_controller = [window rootViewController];

        *stop = (root_view_controller != nil);
    }];

    [root_view_controller presentViewController:activity_view_controller animated:YES completion:nil];
}
