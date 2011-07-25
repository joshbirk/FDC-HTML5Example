<H1>HTML5 Example for Force.com</H1>
<P>
This is just a set of sample code for integrating Offline Databases and Web Application Cache with your Force.com instance.  Some of the code requires a custom object "Quark" to be in existence, and the custom fields "Spin" and "Mass" of number/decimal type.  The example code assumes those fields to be of 1.0 or less value.  The "Neutron Bomb" class has methods for creating 900 quarks with random test data.  You can also create and delete the data within Visualforce via the splash page.
</P>
<P>
The pages make reference to the "HTML5Util" static resource, which is the other directory of files here in addition to the Force.com src directory.
</P>
<P>
To install this on your own org, you can use this link:
<BR />
<a href="https://login.salesforce.com/packaging/installPackage.apexp?p0=04tC0000000tip6">https://login.salesforce.com/packaging/installPackage.apexp?p0=04tC0000000tip6</a>
</P>
Or download here via Git, and <a href="http://blogs.developerforce.com/labs/2011/04/how-to-use-git-github-force-com-ide-open-source-labs-apps.html">see here on more about using Git with Force.com</a>.  This is actually recommended, so that you can get any small updates without having to go get the package again.