Overview
=============
This class is a Mac OS X replacement of NSTextFieldCell class that interprets Bold HTML tags (&lt;b&gt;) in the title and subTitle attributes of the TextFieldCell.

<ul>
<li>Parts of title without tags are rendered with <strong>textColor</strong> and <strong>font</strong>;</li>
<li>Parts of title between <b></b> tags are rendered with <strong>highligtedTextColor</strong> and <strong>highligtedTextFont</strong>;</li>
<li>Parts of subTitle without tags are rendered with <strong>subTitleTextColor</strong> and <strong>subTitleTextFont</strong>;</li>
<li>Parts of subTitle between <b></b> tags are rendered with <strong>subTitleHighlightedTextColor</strong> and <strong>subTitleHighlightedTextFont</strong>;</li>
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
- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell
        forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ASTextFieldCell *aCell = (ASTextFieldCell *)cell;
    aCell.title = @"&lt;b&gt;Highlighted&lt;/b&gt; title";
    aCell.subTitle = @"&lt;b&gt;Highlighted&lt;/b&gt; subTitle";
}
</pre>
