### Excel Date Issue – Explanation

While working on the first Excel solution, the `created_at` value in the **feedbacks** sheet sometimes appears as a number (for example: `44427.69841`) instead of a proper date and time.

This happens because Excel does not store dates as text. Instead, it stores them as **serial numbers**:

* The **integer part** represents the number of days passed since the base date (January 0, 1900).

  * Example: `44427` corresponds to **2021-08-19**
* The **decimal part** represents the time as a fraction of a 24-hour day.

  * `0.5` means **12:00 PM**
  * `0.69841` is approximately **16:45:43**

So, the value `44427.69841` actually represents:
**2021-08-19 16:45:43**

---

### Why this issue appears

The value is stored correctly by Excel, but the cell is formatted as **General** or **Number**, so it shows the raw serial value instead of a readable date.

---

### How to fix it

To display the correct date and time:

1. Right-click on the cell
2. Select **Format Cells**
3. Go to **Number → Date** or choose **Custom**
4. Use the format:
   `yyyy-mm-dd hh:mm:ss`

After applying the format, the number will be displayed as a proper timestamp.

---

### Conclusion

This is not an error in the formula or data. It is simply a formatting issue. Once the correct date/time format is applied, the value will be displayed in a human-readable form.
