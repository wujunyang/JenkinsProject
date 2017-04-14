
#路径
project_info_path="/Users/Shared/Jenkins/Home/jobs/JenkinsProject/workspace"
project_AutomaticPacking="/Users/Shared/Jenkins/Home/jobs/JenkinsProject/AutomaticPacking"

#工程名字(Target名字)
Project_Name="JenkinsProject"
#workspace的名字
Workspace_Name="JenkinsProject"
#配置环境，Release或者Debug,默认release
Configuration="Debug"


# info.plist路径
# project_infoplist_path="${project_info_path}/${Project_Name}/Info.plist"
#取版本号
# bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "${project_infoplist_path}")

# 设置ipa名称
# DATE="$(date +%Y%m%d)"
# IPANAME="${Project_Name}_${Configuration}_V${bundleShortVersion}_${DATE}.ipa"

#AdHoc版本的Bundle ID
AdHocBundleID="com.xxxx"
#AppStore版本的Bundle ID
AppStoreBundleID="com.xxxx"
#enterprise的Bundle ID
EnterpriseBundleID="wjy.com.MobileProject"

# ADHOC证书名#描述文件
ADHOCCODE_SIGN_IDENTITY="iPhone Distribution: xxxx"
ADHOCPROVISIONING_PROFILE_NAME="xxxxx-xxxx-xxxx-xxxx-xxxxxx"

#AppStore证书名#描述文件
APPSTORECODE_SIGN_IDENTITY="iPhone Distribution: xxxxx"
APPSTOREROVISIONING_PROFILE_NAME="xxxxx-xxxx-xxxx-xxxx-xxxxxx"

#企业(enterprise)证书名#描述文件
ENTERPRISECODE_SIGN_IDENTITY="iPhone Distrirmation Science & Technology Co.,Ltd"
ENTERPRISEROVISIONING_PROFILE_NAME="0dd43eba-c1c7070a25c8"

#加载各个版本的plist文件
ADHOCExportOptionsPlist=$project_AutomaticPacking/ADHOCExportOptionsPlist.plist
AppStoreExportOptionsPlist=$project_AutomaticPacking/AppStoreExportOptionsPlist.plist
EnterpriseExportOptionsPlist=$project_AutomaticPacking/EnterpriseExportOptionsPlist.plist

ADHOCExportOptionsPlist=${ADHOCExportOptionsPlist}
AppStoreExportOptionsPlist=${AppStoreExportOptionsPlist}
EnterpriseExportOptionsPlist=${EnterpriseExportOptionsPlist}

# echo "~~~~~~~~~~~~选择打包方式(输入序号)~~~~~~~~~~~~~~~"
# echo "		1 adHoc"
# echo "		2 AppStore"
# echo "		3 Enterprise"

# 读取用户输入并存到变量里
#read parameter
#sleep 0.5
#method="$parameter"
#直接设置固定让它只打第三个
method=3

# 判读用户是否有输入
if [ -n "$method" ]
then
    if [ "$method" = "1" ]
    then
#adhoc脚本
xcodebuild -workspace $project_info_path/$Workspace_Name.xcworkspace -scheme $Project_Name -configuration $Configuration -archivePath $project_info_path/build/$Project_Name-adhoc.xcarchive clean archive build CODE_SIGN_IDENTITY="${ADHOCCODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${ADHOCPROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${AdHocBundleID}"
xcodebuild  -exportArchive -archivePath $project_info_path/build/$Project_Name-adhoc.xcarchive -exportOptionsPlist ${ADHOCExportOptionsPlist} -exportPath $project_info_path/$Project_Name

    elif [ "$method" = "2" ]
    then
#appstore脚本
xcodebuild -workspace $project_info_path/$Workspace_Name.xcworkspace -scheme $Project_Name -configuration $Configuration -archivePath $project_info_path/build/$Project_Name-appstore.xcarchive archive build CODE_SIGN_IDENTITY="${APPSTORECODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${APPSTOREROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${AppStoreBundleID}"
xcodebuild  -exportArchive -archivePath $project_info_path/build/$Project_Name-appstore.xcarchive -exportOptionsPlist ${AppStoreExportOptionsPlist} -exportPath $project_info_path/$Project_Name

    elif [ "$method" = "3" ]
    then
#企业打包脚本
xcodebuild -workspace $project_info_path/$Workspace_Name.xcworkspace -scheme $Project_Name -configuration $Configuration -archivePath $project_info_path/build/$Project_Name-enterprise.xcarchive archive build CODE_SIGN_IDENTITY="${ENTERPRISECODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${ENTERPRISEROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${EnterpriseBundleID}"
xcodebuild  -exportArchive -archivePath $project_info_path/build/$Project_Name-enterprise.xcarchive -exportOptionsPlist ${EnterpriseExportOptionsPlist} -exportPath $project_info_path/$Project_Name
    else
    echo "参数无效...."
    exit 1
    fi
fi
