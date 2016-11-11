//
//  Enums.h
//  boxfish-english
//
//  Created by echo on 14-11-19.
//  Copyright (c) 2014年 boxfish. All rights reserved.
//

#pragma once

typedef NS_ENUM(NSInteger, MyAppType)
{
    StudentType = 0,
    TeacherType,
} ;

//定义题目回答的标记
typedef NS_ENUM(NSInteger, AnswerFlag)
{
    RightFlagViewTag = 1000,
    WrongFlagViewTag,
    SelectedFlagViewTag,
    UnSelectedFlagViewTag
};

//定义答题结果
typedef NS_ENUM(NSInteger, AnswerResult){
    AnswerRight = 0,
    AnswerWrong
};

//滑动方向
typedef NS_ENUM(NSInteger, SwipeDirection)
{
    SwipeLeft = 0,
    SwipeRight
} ;

//定义目录枚举
typedef NS_ENUM(NSInteger, PathType){
    DocumentType = 0,
    CacheType
};

//对话框字体类型
typedef NS_ENUM(NSInteger, DialogueFontStyle){
    DialogueFontStyle1 = 0,
    DialogueFontStyle2
} ;

typedef NS_ENUM(NSInteger, ScrollType)
{
    HorizontalScroll = 0,
    VeticalScroll
} ;

typedef NS_ENUM(NSInteger, PageType) {
    NoTemplate = -1,
    MainTypeBegin = 0,                  //主类型开始的枚举值
    CourseContent = MainTypeBegin,      //综合学习
    SelectImageByWord,                  //看文字选图
    SelectImageBySound,                 //听音选图
    FillBlanksBySelectWords,            //选词填空
    LookAndSay,                         //看图说话
    SelectTextAnswer,                   //选择文字答案
    Dictation,                          //听写题
    SortPractice,                       //排序题
    ClassifyPractice,                   //分类题
    ComprehensiveTest = 9,              //阅读/听力理解题
    TestExam = 10,                      //考试
    Dialogue = 11,                      //对话
    Exercise = 12,                      //练习，用在教师版的练习模块中
    SelectImageByListenArticle,         //听文章选图
    OpenQuestion,                       //开放式问答
    LeadIn,                             //Lead In
    AppreciationVideo,                  //视频欣赏
    
    CourseSubTypeBegin = 100,           //综合学习的子类型开始枚举值
    WordsLearning = CourseSubTypeBegin, //单词学习
    VideoLearning,                      //视频学习
    AudioLearning,                      //音频学习
    GrammarTitle,                       //语法标题
    GrammarLearning,                    //语法学习
    MindMap,                            //思维导图
    OralLearningSurface = 106,          //口语学习封面
    OralLearningDetail,                 //口语学习详细
    OralLearningSummary,                //口语学习总结
    WrittingLearningSurface = 109,      //写作学习封面
    WrittingLearningDetail,             //写作学习详细
    WrittingLearningSummary,            //写作学习总结
    SimpleDialogue = 112,               //对话模板
    ComprehensiveExplanation,           //阅读理解（包含逻辑树功能）
    ClozeTest,                          //完形填空
    GrammarTeacherNew,                  //老师版新语法模板
    
    CommonTypeBegin = 200,
    CommonTitle = CommonTypeBegin,      //通用的学习封面
    CommonSummary,                      //通用的学习总结
    CommonTitlePattern1,                //带主标题、图标、副标题的标题模板
    
    HomeworkBegin = 300,                //作业类型开始枚举值
    SentenceExercise = HomeworkBegin,   //句型练习题
    
    CompositionBegin = 310,             //作文题作业开始枚举值
    PointOfViewType = CompositionBegin,
    WrittingByReadingType,
    WrittingByMediaType,
    ExplanationByEnglish,
    
    OralPracticeBegin = 320,            //口语练习题开始枚举值
    OralPracticeByQuestion = OralPracticeBegin, //回答问题
    OralPracticeByViewMedia,            //看媒体
    OralPracticeByViewArticle,          //看文章
    
    ListenAndReadBegin = 330,           //听读题开始枚举值
    ListenAndReadByArticle = ListenAndReadBegin, //听读文章
    ListenAndReadBySentence,            //听读句子或者单词（可以进行发音对比）
    
    HomeworkReviewResultBegin = 400,    //作业结果
    HomeworkReviewResult = HomeworkReviewResultBegin,
    GrammarSummary = 402,               //语法总结
    SentenceHomeworkReviewResult = 410,
    OralHomeworkReviewResult = 420,
    
    SelfStudyBegin = 500,               //课程学习
    SelfWordStudy = SelfStudyBegin,     //单词学习
    SelfVideoStudy,                     //个人视频学习
    SelfReadingWithVoiceStudy,          //个人听读学习
    SelfPureReadingStudy,               //个人纯阅读学习
    SelfStudyTest,                      //个人学习测试
} ;

//题目的分值类型
typedef NS_ENUM(NSInteger, ScoreType){
    BasicScore = 10,
    DoubleScore = 2 * BasicScore,
    TripleScore = 3 * BasicScore,
    FourTimesScore = 4 * BasicScore
} ;

typedef NS_ENUM(NSInteger, CounterLength){
    NoCounter = 0,
    BasicCounterLength = 20,
    DoubleCounterLength = 2 * BasicCounterLength
} ;

typedef NS_ENUM(NSInteger, PageCourseType){
    ArticalLearning = 0,
    WordLearning,
    DoExercise,
    DoListen,
    DoExam
} ;

typedef NS_ENUM(NSInteger, CourseSection) {
    LearningSection = 0,
    ExerciseSection,
    ListeningSection,
    ExamSection
} ;

typedef NS_ENUM(NSInteger, WordLevelType)
{
    OtherLevel = 0,
    PrimarySchoolLevel,
    JuniorHighSchoolLevel,
    SeniorHighSchoolLevel,
    ToeflLevel
} ;

typedef NS_ENUM(NSInteger, FrameOptions) {
    FrameOptionsX,
    FrameOptionsY,
    FrameOptionsWidth,
    FrameOptionsHeight,
};

//图像自适应类型
typedef NS_ENUM(NSInteger, ImageAutoFitType)
{
    ImageFitNone = 0,
    ImageFixedHeight,
    ImageFixedWidth,
    ImageInscribed,
    ImageCircumscribed
};

//句子单元类型
typedef NS_ENUM(NSInteger, SentenceUnitType)
{
    Adverbial = 0,
    SentenceTrunk,
    SentenceBranch
} ;

typedef NS_ENUM(NSInteger, TestViewManagerType)
{
    ManageCourseViewType = 0,
    ManageExamCandidateType
} ;

typedef NS_ENUM(NSInteger, ExamDifficulty)
{
    EasyExam = 0,
    NormalExam,
    DifficultExam
} ;

typedef NS_ENUM(NSInteger, ExamType)
{
    SelectionType = 0,
    ReadingType,
    ClozeTestType
} ;

typedef NS_ENUM(NSInteger, ExamCoverType) {
    TextExamCoverType = 0,
    ListeningExamCoverType
} ;

typedef NS_ENUM(NSInteger, ExamItemType) {
    NotExamType = -1,
    MultipleChoiceExamType = 0,
    ReadingComprehensionExamType,
    ClozeTestExamType
};

typedef NS_ENUM(NSInteger, ReleaseCourseRecieverState)
{
    ReleaseCourseRecieverStateNormal,
    ReleaseCourseRecieverStateSelected,
};

typedef NS_ENUM(NSInteger, TeachetTeachSource)
{
    TeachetTeachSourceBookShelf,
    TeachetTeachSourceCourseTimeTable
};

typedef NS_ENUM(NSInteger, StudentStudyType)
{
    StudentStudyTypeBookShelf,
    StudentStudyTypeTeacherRecommend,
    StudentStudyTypeBoxfishRecommend,
    StudentStudyTypeHistory,
};

typedef NS_ENUM(NSInteger, StudyStatisticsViewType){
    StudyStatisticsViewTypeClass,
    StudyStatisticsViewTypeStudent,
    StudyStatisticsViewTypeClassRecommend,
};

typedef NS_ENUM(NSInteger, EasemobLoginState){
    EasemobLoginStateLogingin,
    EasemobLoginStateLoginSuccessed,
    EasemobLoginStateLoginFailed,
};

typedef NS_ENUM(NSInteger, recordState) {
    recordStateStop,
    recordStateRecording,
    recordStateCanceling,
    recordStateFailed,
    recordStateShortTime,
};

typedef NS_ENUM(NSInteger, WrongDateStatus)
{
    WrongDateItemsUnCompleted = 0, //本日的错题尚未全部做过
    WrongDateItemsCompleted //本日的错题已经全部做过
};

typedef NS_ENUM(NSInteger, CompareMethod)
{
    EqualMethod = 0,
    NoLessThanMethod, //大于等于
};

//课程内显示标题的类型
typedef NS_ENUM(NSInteger, CourseTitleType)
{
    CourseTitleTypeProgress = 0,
    CourseTitleTypeStudyMode,
};

typedef NS_ENUM(NSInteger, GuidanceButtonType) {
    GuidanceButtonTypeWords,
    GuidanceButtonTypeArticle,
    GuidanceButtonTypeAnswer,
};

// 课程显示模式
typedef NS_ENUM(NSInteger, CourseViewDisplayMode) {
    CourseViewDisplayModeLocalDeviceScreen = 0, // 本地显示模式
    CourseViewDisplayModeLocalExternalScreen,   // 本地外部屏幕显示模式
    CourseViewDisplayModeRemoteScreen           // 远程显示模式
};

// 授课状态
typedef NS_ENUM(NSInteger, TeachMode) {
    TeachModeInClass,     // 课堂教学模式
    TeachModeOnline,      // 在线授课模式
    TeachModePrepare      // 备课模式
};

//
typedef NS_ENUM(NSInteger, DrawPenColor) {
    DrawPenColorRed,
    DrawPenColorBlue,
    DrawPenColorYellow
};

//语音识别原文类型
typedef NS_ENUM(NSInteger, SpeechRecognizeType) {
    SpeechRecognizeTypeSentences,
    SpeechRecognizeTypePassages,
    SpeechRecognizeTypeOpenAnswers,
};

//多媒体类型
typedef NS_ENUM(NSInteger, MultiMediaType) {
    MultiMediaTypeNone = 0,
    MultiMediaTypeImage,
    MultiMediaTypeAudio,
    MultiMediaTypeVideo
};

typedef NS_ENUM(NSInteger, CommonDownloadStatus) {
    CommonDwonloadEnd = 0,
    CommonDownloadingNormal,
    CommonDownloadingInAdvance,
};

// 支付方式
typedef NS_ENUM(NSInteger,PayWayType) {
    PayWayTypeAlipay = 10,
    PayWayTypeWeixinPay = 20,
    PayWayTypePayByAnother = 30,
};

typedef NS_ENUM(NSInteger, CourseScheduleStatus) {
    CourseScheduleStatusFinish,                                // 上课完成
    CourseScheduleStatusUnAppointment,                         // 未约课
    CourseScheduleStatusAbsenteeismTeacher,                    // 老师旷课
    CourseScheduleStatusAbsenteeismStudent,                    // 学生旷课
    CourseScheduleStatusLeaveEarlyTeacher,                     // 教师早退
    CourseScheduleStatusLeaveEarlyStudent,                     // 学生早退
    CourseScheduleStatusStartClass,                            // 上课进行中(包含匹配课没上)
    CourseScheduleStatusFreeze,                                // 课程被冻结(isFreeze为1，学生连续旷课两节兑换的课程)
    CourseScheduleStatusUnknow,                                // 未知
};

/**
 *  套餐详情
 */
typedef NS_ENUM(NSInteger,ProductCodeType) {
    /**
     *  中教课程
     */
    ProductCodeCN = 1001,
    /**
     *  外教点评
     */
    ProductCodeFRN = 1002
};

/**
 *  进入选时间界面的方式
 */
typedef NS_ENUM(NSInteger,SelectTimeServerCourseType) {
    /**
     *  (预约上课)正常购买流程进入
     */
    SelectTimeServerCourseType_TakeLessons,
    /**
     *  (我)我的学习记录进入
     */
    SelectTimeServerCourseType_MineSetting,
    /**
     *  通过金币换课程进入
     */
    SelectTimeServerCourseType_GlodenExchange
};

//首页课堂类型
typedef NS_ENUM(NSInteger, BFEStudentClassCatalogType) {
    BFEStudentClassCatalogTypeSelfStudy,
    BFEStudentClassCatalogTypeForeignTeacher,
    BFEStudentClassCatalogTypeForeignTeacherComment,
    BFEStudentClassCatalogTypeChineseTeacher,
};

//首页课程标签类型
typedef NS_ENUM(NSInteger, BFEStudentCourseLabelType) {
    BFEStudentCourseLabelTypeNone,
    BFEStudentCourseLabelTypeNew,
    BFEStudentCourseLabelTypeRecommend,
    BFEStudentCourseLabelTypeReview,
    BFEStudentCourseLabelTypeHomeWork,
    BFEStudentCourseLabelTypeLatest,
};
