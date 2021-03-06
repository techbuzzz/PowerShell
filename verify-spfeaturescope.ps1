#author: landon bass
#verifies features without a scope, which have been caused during orphaned deployments

#NOTE:this should be run on each server, as I have seen features orphaned on some servers and not others

add-pssnapin microsoft.sharepoint.powershell -ea 0

cls

function verify-spfeaturescope () {
    try {
        get-spfeature | ? {$_.scope -eq "" -or $_.scope -eq $null} | % {
            $name = $_ | select -expandproperty displayname
            $id   = $_ | select -expandproperty id
            write-host "feature with id: $id and name: $name has an invalid scope"
        }
    }
    catch {
        write-host -foregroundcolor red "error:" $_
    }
}

verify-spfeaturescope
