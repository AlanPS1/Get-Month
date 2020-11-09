Function Get-Month {

    <#
    .SYNOPSIS
    Get-Month
    .DESCRIPTION
    This command get a month's start date & end date. It looks for the very first
    second of the first day and the very last second of the last day. It populates 2 global
    variables called $Global:StartOfMonth & $Global:EndOfMonth. These can be captured from 
    the PowerShell session using $StartOfMonth & $EndOfMonth. 

    It is most likely that this advanced function will be private and used as a helper function.
    Other scripts that require to report on a calendar month will call this function and utilise
    the contents of $StartOfMonth & $EndOfMonth

    .PARAMETER ThisMonth
    Get's the start date and end date for the "This month", the current month.

    .PARAMETER NextMonth
    Get's the start date and end date for the "Next month", the coming month.

    .PARAMETER LastMonth
    Get's the start date and end date for the "Last month", the month just past.

    .PARAMETER WhichMonth
    The name of the desired month.
    'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'

    .EXAMPLE
    PS C:\> Get-Month -ThisMonth

    If this were March 2020 then the results would be:

    $StartOfMonth   = '01 March 2020 00:00:00'
    $EndOfMonth     = '31 March 2020 23:59:59'

    .EXAMPLE
    PS C:\> Get-Month -NextMonth

    If this were March 2020 then the results would be:

    $StartOfMonth   = '01 April 2020 00:00:00'
    $EndOfMonth     = '30 April 2020 23:59:59'

    .EXAMPLE
    PS C:\> Get-Month -LastMonth

    If this were March 2020 then the results would be:

    $StartOfMonth   = '01 February 2020 00:00:00'
    $EndOfMonth     = '29 February 2020 23:59:59'

    .EXAMPLE
    PS C:\> Get-Month -WhichMonth January

    If this were March 2020 then the results would be:

    $StartOfMonth   = '01 January 2020 00:00:00'
    $EndOfMonth     = '31 January 2020 23:59:59'

    .EXAMPLE
    PS C:\> Get-Month -WhichMonth November

    If this were March 2020 then the results would be:

    $StartOfMonth   = '01 November 2019 00:00:00'
    $EndOfMonth     = '30 November 2019 23:59:59'

    .NOTES

        Author:  Alan Wightman
        Website: http://AlanPs1.io
        Twitter: @AlanO365

    #>

    [OutputType()]
    [CmdletBinding(DefaultParameterSetName)]
    Param (
        [Parameter(Mandatory = $False, Position = 1)]
        [Switch]$ThisMonth,
        [Parameter(Mandatory = $False, Position = 1)]
        [Switch]$LastMonth,
        [Parameter(Mandatory = $False, Position = 1)]
        [ValidateSet('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')]
        [string[]]$WhichMonth,
        [Parameter(Mandatory = $False, Position = 1)]
        [Switch]$NextMonth
    )

    $Input = $PSBoundParameters

    $CurrentDate = $null
    $CurrentMonth = $null
    $MonthYear = $null
    $Global:Month = $null

    $Global:StartOfMonth = @{}
    $Global:EndOfMonth = @{}

    $CurrentDate = Get-Date
    $CurrentMonth = (($CurrentDate)).ToUniversalTime().Month
    $MonthYear = ($CurrentDate).ToUniversalTime().Year

    # For the default Get-Month only - Params overwrite below if in use.    
    $StartOfMonth = Get-Date -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
    $EndOfMonth = ($StartOfMonth).AddMonths(1).AddTicks(-1)

    # For all non defaul when either paramter is binded, -ThisMonth, -LastMonth, -WhichMonth & -NextMonth
    switch ($PSBoundParameters.Keys) {

        # Get-Month -ThisMonth
        ThisMonth { 
            
            $StartOfMonth = Get-Date -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
            $EndOfMonth = ($StartOfMonth).AddMonths(1).AddTicks(-1)

        }

        LastMonth {

            If ([int]$CurrentMonth -eq "1") {
                # Set to Last Year
                $MonthYear = (($CurrentDate).AddYears(-1)).ToUniversalTime().Year 
            }
            Else { 
                # Set to this year
                $MonthYear = ($CurrentDate).ToUniversalTime().Year 
            }

            $Month = (($CurrentDate)).ToUniversalTime().AddMonths(-1).Month
            $StartOfMonth = Get-Date -Month $Month -Year $MonthYear -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
            $EndOfMonth = ($StartOfMonth).AddMonths(1).AddTicks(-1)

        }

        # Get-Month -WhichMonth January
        WhichMonth {
            
            ForEach ($Item in $PSBoundParameters.WhichMonth) { 

                Switch ($Item) {

                    January     { $Month = '1' }
                    February    { $Month = '2' }
                    March       { $Month = '3' }
                    April       { $Month = '4' }
                    May         { $Month = '5' }
                    June        { $Month = '6' }
                    July        { $Month = '7' }
                    August      { $Month = '8' }
                    September   { $Month = '9' }
                    October     { $Month = '10' }
                    November    { $Month = '11' }
                    December    { $Month = '12' }

                }

                If ([int]$Month -gt [int]$CurrentMonth) {
                    # Set to Last Year
                    $MonthYear = (($CurrentDate).AddYears(-1)).ToUniversalTime().Year 
                }
                Else { 
                    # Set to this year
                    $MonthYear = ($CurrentDate).ToUniversalTime().Year 
                }

                #Testing Only
                # Write-Output "Log time frame: $StartOfMonth - $EndOfMonth"

                # PS Custom Object to be added to support multiple months added to the array
            
            }

            $StartOfMonth = Get-Date -Month $Month -Year $MonthYear -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
            $EndOfMonth = ($StartOfMonth).AddMonths(1).AddTicks(-1)

        }

        # Get-Month -NextMonth
        NextMonth {

            $Month = (($CurrentDate)).ToUniversalTime().AddMonths(1).Month

            If ([int]$Month -eq 1) {
                # Set to Last Year
                $MonthYear = (($CurrentDate).AddYears(1)).ToUniversalTime().Year 
            }
            Else { 
                # Set to this year
                $MonthYear = ($CurrentDate).ToUniversalTime().Year 
            }

            $Global:StartOfMonth = Get-Date -Month $Month -Year $MonthYear -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
            $Global:EndOfMonth = ($StartOfMonth).AddMonths(1).AddTicks(-1)

        }

    } # End of Switch on $PSBoundParameters.Keys

    # Testing output purposes only - to be removed
    # Write-Output "Log time frame: $StartOfMonth - $EndOfMonth"

}