"# Data-Analyst_Assignment" 
In Excel 1st solution we get feedbacks created_at value as some number(ex:44427.69841,) because
Excel stores dates as serial numbers:
Integer part → number of days since Jan 0, 1900
Example: 44427 → 44427 days after Jan 0, 1900 → corresponds to 2021-08-19
Decimal part → fraction of a 24-hour day (time)
0.5 → 12:00 PM
0.69841 → ~16:45:43 (16 hours, 45 minutes, 43 seconds)
Converting this to readable format:
Format the cell:
Right-click → Format Cells → Number → Date or Custom
Custom format: yyyy-mm-dd hh:mm:ss
After formatting, 44427.69841 becomes:
2021-08-19 16:45:43
Why you see a number instead of a date
Excel is storing it correctly internally; it’s just formatted as General or Number.
Once you change the cell format to Date/Time, it will display properly.
