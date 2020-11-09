# Get-Month

The idea here is to make a function that can be sued to capture 1 months data for auditing purposes. Pipeline compatability will be used so that other date orients PowerShell Cmdlets can intergrate with it.

This was copied and pasted from a script I wrote. The function, "Get-Month" was a worker function but it got me thinking about the potential of a function that is further developped and could scale out.

## ShouldDo
#### (to be continued)

+ Handle multiple standard date & time formats
+ PipeLine compatible
+ Work for 12 months of the year in English
+ For the current year, if the Month requested is December and December is still to come, assume the year prior

## ToDo - off the top of my head
#### (to be continued)

+ PipeLine compatability
+ Address variable scope etc
+ Handle [format specifiers](https://docs.microsoft.com/en-us/dotnet/standard/base-types/standard-date-and-time-format-strings#table-of-format-specifiers)
+ Handle cultures. See [Get-Culture](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-culture?view=powershell-7)

<img src="https://octodex.github.com/images/stormtroopocat.jpg" alt="The Stormtroopocat" width="65" height="67"/>
