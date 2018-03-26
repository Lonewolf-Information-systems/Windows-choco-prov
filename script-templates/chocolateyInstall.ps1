$name   = "start10"
$url    = "http://stardock.cachefly.net/Start10-sd-setup.exe"
$kind   = "EXE"
$silent = "/SILENT /NOREBOOT"

Install-ChocolateyPackage $name $kind $silent $url
