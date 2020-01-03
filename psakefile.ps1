Task Publish -Depends Pack {
}
 
Task Pack -Depends Build, EstimateVersions {
}
 
Task EstimateVersions {
    $script:VersionTags = @()
 
    if ($Latest) {
        $script:VersionTags += 'latest'
    }
 
    if (!!($Version)) {
        $Version = [Version]$Version
 
        Assert ($Version.Revision -eq -1) "Version should be formatted as Major.Minor.Patch like 1.2.3"
        Assert ($Version.Build -ne -1) "Version should be formatted as Major.Minor.Patch like 1.2.3"
 
        $Version = $Version.ToString()
        $script:VersionTags += $Version
    }
 
    Assert $script:VersionTags "No version parameter (latest or specific version) is passed."
}
 
Task Build -Depends Clean {
}
 
Task Clean -Depends Init {
}
 
Task Init {
    $date = Get-Date
    $ticks = $date.Ticks
    $trashFolder = Join-Path -Path . -ChildPath ".trash"
    $script:trashFolder = Join-Path -Path $trashFolder -ChildPath $ticks.ToString("D19")
    New-Item -Path $script:trashFolder -ItemType Directory
    $script:trashFolder = Resolve-Path -Path $script:trashFolder
}