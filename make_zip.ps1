[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
$connstr = "server=cdisc.co.kr ;Port=3306; uid=root; pwd =236p@ssw0rd; Database=soa_log"
$conn = New-Object MySql.Data.MySqlClient.MySqlConnection($connstr)
$conn.open()
$query = "select * from oafile where file is not null;"
$cmd = New-Object MySql.Data.MySqlClient.MySqlCommand($query, $conn)
$dataadapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($cmd)
$dataset = New-Object system.data.dataset
$recordcount = $dataadapter.fill($dataset, "oafile")
$qresult = $dataset.Tables["oafile"]

$zip_proc = "'*/Bandizip.exe, '*/ALZip.exe, '*7z.exe, '*Winzip.exe, '*WinRAR.exe, '*BreadZip.exe, '*HanZip.exe"

$exreadcontrol = ($qresult | Where-Object {($_.accessmask -eq "READ_CONTROL") -and ($_.PSname -match "'*/Bandizip.exe") -or ($_.PSname -match "'*/ALZip.exe") -or ($_.PSname -match "'*7z.exe") -or ($_.PSname -match "'*Winzip.exe") -or ($_.PSname -match "'*WinRAR.exe") -or ($_.PSname -match "'*BreadZip.exe") -or ($_.PSname -match "'*HanZip.exe")} | select DiskSN, IP, MAC, cname, uname, root, directory, datetime, file, ext)

$exwritedata = ($qresult | Where-Object {($_.accessmask -eq "WriteData (or AddFile)") -and ($_.PSname -match "'*/Bandizip.exe")-or ($_.PSname -match "'*/ALZip.exe") -or ($_.PSname -match "'*7z.exe") -or ($_.PSname -match "'*Winzip.exe") -or ($_.PSname -match "'*WinRAR.exe") -or ($_.PSname -match "'*BreadZip.exe") -or ($_.PSname -match "'*HanZip.exe")} | select DiskSN, IP, MAC, cname, uname, root, directory, datetime, file, ext)

<# -------------------------------------------------------------------------------------------------------------------------------------#>
$exdelete = ($qresult | Where-Object {($_.accessmask -eq "DELETE") -and ($_.PSname -match "'*/Bandizip.exe")-or ($_.PSname -match "'*/ALZip.exe") -or ($_.PSname -match "'*7z.exe") -or ($_.PSname -match "'*Winzip.exe") -or ($_.PSname -match "'*WinRAR.exe") -or ($_.PSname -match "'*BreadZip.exe") -or ($_.PSname -match "'*HanZip.exe")} | select DiskSN, IP, MAC, cname, uname, root, directory, datetime, file, ext)
<# -------------------------------------------------------------------------------------------------------------------------------------#>

$exreadattributes = ($qresult | Where-Object {($_.accessmask -eq "ReadAttributes") -and ($_.PSname -match "'*/Bandizip.exe")-or ($_.PSname -match "'*/ALZip.exe") -or ($_.PSname -match "'*7z.exe") -or ($_.PSname -match "'*Winzip.exe") -or ($_.PSname -match "'*WinRAR.exe") -or ($_.PSname -match "'*BreadZip.exe") -or ($_.PSname -match "'*HanZip.exe")} | select DiskSN, IP, MAC, cname, uname, root, directory, datetime, file, ext)

$exwritedata = ($qresult | Where-Object {($_.accessmask -eq "ReadData (or ListDirectory)") -and ($_.PSname -match "'*/Bandizip.exe")-or ($_.PSname -match "'*/ALZip.exe") -or ($_.PSname -match "'*7z.exe") -or ($_.PSname -match "'*Winzip.exe") -or ($_.PSname -match "'*WinRAR.exe") -or ($_.PSname -match "'*BreadZip.exe") -or ($_.PSname -match "'*HanZip.exe")} | select DiskSN, IP, MAC, cname, uname, root, directory, datetime, file, ext)
<# -------------------------------------------------------------------------------------------------------------------------------------#>

foreach ($ziptime in $exdelete)
{
$zip_hour = $ziptime.datetime.split(":")[0]
$zip_min = $ziptime.datetime.split(":")[1]
$zip_sec = $ziptime.datetime.split(":")[2].split("+")[0]
foreach($result1 in $exreadattributes)
{
$ra_hour = $result1.datetime.split(":")[0]
$ra_min = $result1.datetime.split(":")[1]
$ra_sec = $result1.datetime.split(":")[2].split("+")[0]

foreach ($result in $exwritedata)
{
if($result1.datetime -eq $result.datetime -and $result1.file -eq $result.file)
{
    if(($zip_hour -eq $ra_hour) -and ($zip_min -eq $ra_min) -and (($zip_sec -eq $ra_sec) -or ([int]$zip_sec -eq [int]$ra_sec+1) -or ([int]$zip_sec -eq [int]$ra_sec+2) -or ([int]$zip_sec -eq [int]$ra_sec+3) -or ([int]$zip_sec -eq [int]$ra_sec+4) -or ([int]$zip_sec -eq [int]$ra_sec+5)))
    { 
    $result1
    $ziptime
    "========================"
    break
    }
} 
}
}
}
$conn.close()