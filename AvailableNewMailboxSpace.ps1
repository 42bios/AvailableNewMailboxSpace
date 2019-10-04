if ( (Get-PSSnapin -Name Microsoft.Exchange.Management.PowerShell.E2010 -ErrorAction:SilentlyContinue) -eq $null)
{
    Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010
}
$customer = "DBNAME"
$minDBfree = "2048"

$NagiosStatus = "0"
$NagiosDescription = ""

$db = Get-MailboxDatabase -Status $customer | select name
$dbf = Get-MailboxDatabase -Status $customer | select AvailableNewMailboxSpace

$dbfreeMB = $dbf.AvailableNewMailboxSpace.ToMB()




    if ($minDBfree -gt $dbfreeMB)
    {
        if ($NagiosDescription -ne "") 
		{
			# Format the output for Nagios
			$NagiosDescription = $NagiosDescription + ", "
		}
        
	       $NagiosDescription = $NagiosDescription + $db.Name + " = " + $dbfreeMB		
            # Set the status to failed.
		      $NagiosStatus = "2 "

  
    
    } #end if
   if ($NagiosStatus -eq "2") 
{
	Write-Host ""$NagiosDescription" MB ($dbfreeMB MiB) in use. Max. allowed is: "$minDBfree" MB | 'DBsizeMiB'=${dbfreeMB}"
	

} 
else 
{	
Write-Host "Database: "$dbfreeMB" MiB | 'DBsizeMiB'=${dbfreeMB}"

}



exit $NagiosStatus