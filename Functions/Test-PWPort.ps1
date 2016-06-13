# Test-PWPort based on TestPort function from http://www.travisgan.com/2014/03/use-powershell-to-test-port.html
# Place function in your profile.ps1 file to have available at all times.
# ProjectWise default port of 5800 is hardcoded.
# Usage:
#	Test-PWPort <servername>
#	Test-PWPort <ip_address>
# Returns:
#	True if port is listening
#	False if can not connect to port

function Test-PWPort {
	Param(
		[parameter(ParameterSetName='ComputerName', Position=0)]
		[string]
		$ComputerName,

		[parameter(ParameterSetName='IP', Position=0)]
		[System.Net.IPAddress]
		$IPAddress
		)
	$Port = 5800
	$RemoteServer = If ([string]::IsNullOrEmpty($ComputerName)) {$IPAddress} Else {$ComputerName};

	$test = New-Object System.Net.Sockets.TcpClient;
	$result = $false
	Try
	{
		$test.Connect($RemoteServer, $Port);
		$result = $true
	}
	Catch
	{
		$result = $false
	}
	Finally
	{
		$test.Dispose();
	}
	return $result
}
