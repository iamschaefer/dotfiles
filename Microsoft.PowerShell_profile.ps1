# quick navigation to home directory
function ~ { cd ~ }
$myvimrc = "$env:userprofile/_vimrc"

. (Join-Path -Path (Split-Path -Parent -Path $PROFILE) -ChildPath $(switch($HOST.UI.RawUI.BackgroundColor.ToString()){'White'{'Set-SolarizedLightColorDefaults.ps1'}'Black'{'Set-SolarizedDarkColorDefaults.ps1'}default{return}}))

# behave like default bash command line
Set-PSReadlineOption -EditMode emacs

# ttd specific
if($env:userdomain -eq "THETRADEDESK"){

  . "$env:TTD_HG_EXTENSIONS/review.ps1"

  (Join-Path -Path (Split-Path -Parent -Path $PROFILE) -ChildPath "hgmergecheck.ps1")

  function src { cd $env:adplatformroot }
  function src2 { cd C:\src\AdPlatform-PublicAPI-clone2\AdPlatform}
}
