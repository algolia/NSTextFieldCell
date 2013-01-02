Overview
=============
This class is a Mac OS X replacement of NSTextFieldCell class that interprets Bold HTML tags (&lt;b&gt;) in the title and subTitle attributes of the TextFieldCell.

<ul>
<li>Parts of title without tags are rendered with <strong>textColor</strong> and <strong>font</strong>;</li>
<li>Parts of title between <b></b> tags are rendered with **highligtedTextColor** and **highligtedTextFont**;</li>
<li>Parts of subTitle without tags are rendered with **subTitleTextColor** and **subTitleTextFont**;</li>
<li>Parts of subTitle between <b></b> tags are rendered with **subTitleHighlightedTextColor** and **subTitleHighlightedTextFont**;</li>
</ul>

This implementation is faster than NSWebView and is perfect for '''NSTableView''', it is very easy to customize it for your needs.

Example
=============

Here is how to set ASTextFieldCell as cell of NSTableView:
<pre>
NSTableColumn *tableColumn = [[tableView tableColumns] objectAtIndex:0];
ASTextFieldCell *customHighlights = [[ASTextFieldCell alloc] init];
[tableColumn setDataCell:customHighlights];
</pre>

And here is an usage example:
<pre>
- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ASTextFieldCell *aCell = (ASTextFieldCell *)cell;
    aCell.title = @"<b>Highlighted</b> title";
    aCell.subTitle = @"<b>Highlighted</b> subTitle";
}
</pre>
