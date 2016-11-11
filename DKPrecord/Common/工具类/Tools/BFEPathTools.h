//
//  PathTools.h
//  boxfish-english
//
//  Created by echo on 14-11-19.
//  Copyright (c) 2014年 boxfish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFEPathTools : NSObject

+ (NSString *)getDocumentDirectoryPath;
+ (NSString *)getDocumentDirectoryPathDataBasePath:(NSString *)dbName;
+ (BOOL)isFileInDocumentDirectoryExist:(NSString*)fileName;

+ (NSString*)getAppDocumentPath;

+ (NSString*)getOldCachedResourceFolderPath;
+ (NSString*)getOldApplicationCachedResourceFolderPath;
+ (NSString*)getCachedResourceFolderPath;
+ (NSString *)getCachedResourceForMixFolderPath;

+ (NSString*)getOldUpdatableResourcePath;
+ (NSString*)getUpdatableResourcePath;

+ (NSString*)getAppSupportPath;
+ (NSString*)getAppDataPath;
+ (NSString*)getAppDataRootPath;
+ (NSString*)getSandBoxUpdatableResourcePathBySubpath:(NSString*)subPath;
+ (NSString*)getUpdatableResourcePathBySubpath:(NSString*)subPath;

+ (NSArray*)getAllCachedCategoryInfoFilePathArray:(NSString*)fileSuffix
                                  excludeFileName:(NSString*)excludeFileName
                                         infoPath:(NSString *)infoPath;


@end
