# CheckCCMCacheIntegrity
Check the ConfigMgr ccmcache for inconsistancies by comparing it to WMI (CacheInfoEx) - PowerShell script

The script compares the WMI entries in CacheInfoEx with the folders in c:\windows\ccmcache and vice versa. Any inconsistencies will be listed in red (an entry in WMI doesn’t match the folder) or yellow (a folder exists for which an entry in WMI is missing). It may help you to find out why the size of your ccmcache folder exceeds the limit or to prepare a cleanup of orphaned folders. With a slight modification, you can use the script in a Compliance Item or run it by the console feature 'Script' of the ConfigMgr. You just have to remove all output and create a summary based on the counters $WMIInconsistancies and $orphanedFolderCount.
