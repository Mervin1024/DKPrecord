//
//  PathTools.m
//  boxfish-english
//
//  Created by echo on 14-11-19.
//  Copyright (c) 2014年 boxfish. All rights reserved.
//

#import "BFEPathTools.h"
#import "BFECommonTools.h"

@implementation BFEPathTools

+ (NSString *)getDocumentDirectoryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return documentDirectory;
}

+ (NSString *)getDocumentDirectoryPathDataBasePath:(NSString *)dbName
{
    NSString * documentDirectory = [self getDocumentDirectoryPath];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:dbName];
    NSLog(@"%@",dbPath);
    return dbPath;
}

+ (BOOL)isFileInDocumentDirectoryExist:(NSString*)fileName
{
    NSString *fullpath = [NSString stringWithFormat:@"%@/%@", [self getDocumentDirectoryPath], fileName];
    
    return ([[NSFileManager defaultManager] fileExistsAtPath:fullpath]);
}

+ (NSString*)getAppDocumentPath
{
    NSString *path = [NSString stringWithFormat:@"%@/%@",
                      [self getDocumentDirectoryPath],
                      [BFECommonTools getAppDocumentFolder]];
    return path;
}

+ (NSString*)getOldCachedResourceFolderPath
{
    NSString *path = [NSString stringWithFormat:@"%@/secretResources",CachedDataFolder];
    return path;
}

+ (NSString*)getOldApplicationCachedResourceFolderPath
{
    NSString *path = [NSString stringWithFormat:@"%@/secretResources", [self getAppDataRootPath]];
    return path;
}

+ (NSString*)getCachedResourceFolderPath
{
    NSString *path = [NSString stringWithFormat:@"%@/secretResources", [self getAppDataPath]];
    return path;
}

+ (NSString *)getCachedResourceForMixFolderPath
{
    NSString *path = [NSString stringWithFormat:@"%@/resourceForMix", [self getAppDataPath]];
    return path;
}

+ (NSString*)getOldUpdatableResourcePath
{
    NSString *path = [NSString stringWithFormat:@"%@/updatable", CachedDataFolder];
    return path;
}

+ (NSString*)getUpdatableResourcePath
{
    NSString *path = [NSString stringWithFormat:@"%@/updatable", [self getAppDataRootPath]];
    return path;
}

+ (NSString*)getAppSupportPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *appSupportDirectory = [paths objectAtIndex:0];
    
    return appSupportDirectory;
}

+ (NSString*)getAppDataPath
{
    NSString *folder = [BFECommonTools getAppDocumentFolder];
    NSString *path = [NSString stringWithFormat:@"%@/%@", [self getAppDataRootPath], folder];
    return path;
}

+ (NSString*)getAppDataRootPath
{
    NSString *appSupportDirectory = [self getAppSupportPath];
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *appDataFolder = [NSString stringWithFormat:@"%@/%@/data", appSupportDirectory, bundleId];
    
    return appDataFolder;
}

+ (NSString*)getSandBoxUpdatableResourcePathBySubpath:(NSString*)subPath {
    NSString *path = [self getUpdatableResourcePath];
    path = [NSString stringWithFormat:@"%@/%@", path, subPath];
    return path;
}

+ (NSString*)getUpdatableResourcePathBySubpath:(NSString*)subPath {
    NSString *resourceName = [subPath lastPathComponent];
    if (!resourceName) {
        return nil;
    }
    
    NSString *path = [self getSandBoxUpdatableResourcePathBySubpath:subPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return path;
    } else {
        NSString *subPathWithoutResource = [subPath stringByDeletingLastPathComponent];
        NSString *bundleDirectory = [NSString stringWithFormat:@"updatable/%@", subPathWithoutResource];
        path = [[NSBundle mainBundle] pathForResource:resourceName ofType:nil inDirectory:bundleDirectory];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            return path;
        } else {
            return nil;
        }
    }
}

+ (NSArray*)getAllCachedCategoryInfoFilePathArray:(NSString*)fileSuffix
                                  excludeFileName:(NSString*)excludeFileName
                                         infoPath:(NSString *)infoPath
{
    NSString *dirPath = infoPath;
    NSMutableArray *filenamelist = [[NSMutableArray alloc] init];
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    
    for (NSString *filename in tmplist) {
        NSString *fullpath = [dirPath stringByAppendingPathComponent:filename];
        BOOL isDirectory;
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullpath isDirectory:&isDirectory]) {
            if (isDirectory) {
                [filenamelist addObject:fullpath];
            }
        }
    }
    
    NSMutableArray *allCachedCategoryInfoFilePathArray = [[NSMutableArray alloc] init];
    for (NSString *fullPath in filenamelist) {
        NSArray *infoFileList = [BFEPathTools getFilePathListOfType:fileSuffix fromDirPath:fullPath excludeFileName:excludeFileName];
        if (infoFileList && infoFileList.count > 0) {
            [allCachedCategoryInfoFilePathArray addObjectsFromArray:infoFileList];
        }
    }
    
    return [BFECommonTools getShuffledArray:allCachedCategoryInfoFilePathArray];
}

+ (NSArray*)getFilePathListOfType:(NSString *)type fromDirPath:(NSString *)dirPath excludeFileName:(NSString*)excludeFileName
{
    NSMutableArray *filenamelist = [[NSMutableArray alloc] init];
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    
    for (NSString *filename in tmplist) {
        NSString *fullpath = [dirPath stringByAppendingPathComponent:filename];
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullpath]) {
            if ([[filename pathExtension] isEqualToString:type]) {
                
                // 下载展示页面不展示正在下载的内容
                if (excludeFileName) {
                    NSString *filenameNoExtension = [filename stringByDeletingPathExtension];
                    if (filenameNoExtension) {
                        if ([filenameNoExtension isEqualToString:excludeFileName]) {
                            continue;
                        }
                    }
                }
                
                [filenamelist addObject:fullpath];
            }
        }
    }
    
    return filenamelist;
}

@end
