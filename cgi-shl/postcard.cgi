#!/usr/bin/perl
###########################################################################
#                                                                         #
#                  postcard.cgi - Digital Postcards v1.0                  #
#                                                                         #
#                           Written by Michael Hall                       #
#      Written for Virtual Marketing Technologies - vmt@airmail.net       #
# Copyright ©1997 by Virtual Marketing Technologies, All Rights Reserved. #
#                                                                         #
###########################################################################

$BaseDir =  "/var/www/docs/scripts2/free/postcards"; # Edit this to show where your postcards directory is.
$Pictures = "pics";		# Edit this to show the directory where the pictures are stored.
$PostcardURL = "http://www.virtualcenter.com/scripts2/free/postcards/postcard.cgi"; # Edit this to show the URL to your postcards.cgi script.
$SiteEMail = "vmt\@airmail.net";	# Set this to your site's e-mail address
$SiteURL = "http://www.virtualcenter.com/scripts2";		# Set this to the URL of your web site.
$CardSubject = "Digital Postcard";	# Set this to what you want the subject of the e-mail messages to say.
$SiteName = "The Scripts Home";		# Set this to the name of your web site.
$AllowHTML = 0;  # Yes = 1, No = 0
$mailprog = '/usr/sbin/sendmail';

$Header = "

<HTML>
<HEAD>
  <META NAME=\"GENERATOR\" CONTENT=\"Adobe PageMill 2.0 Mac\">
  <TITLE>Untitled Document</TITLE>
</HEAD>
<BODY BGCOLOR=\"#ffffff\">

<P><IMG SRC=\"titles/Postcards.gif\" ALIGN=\"BOTTOM\"
NATURALSIZEFLAG=\"3\" ALT=\"Casierra Postcards\" BORDER=\"0\"></P>";

#############################################################################
# YOU MAY NOT EDIT ANYTHING BELOW THIS POINT WITHOUT EXPRESS WRITTEN
# PERMISSION OF THE AUTHOR OR VIRTUAL MARKETING TECHNOLOGIES.  FAILURE TO
# ABIDE BY THIS REQUEST VOIDS YOUR LICENSE AND IS A DIRECT VIOLATION OF U.S.
# AND INTERNATIONAL COPYRIGHT LAWS AND SUBJECT TO PROSECUTION.
#############################################################################


&UnWeb;

# Get the Date for Entry
$date = `date +"%A, %B %d, %Y at %T (%Z)"`;
        chop($date);
$shortdate = `date +"%D %T %Z"`;
        chop($shortdate);

if ($in{'action'} eq "send") {

if (($in{'SenderName'} eq "") || ($in{'SenderEMail'} eq "") || ($in{'ReceiveName'} eq "")
	|| ($in{'ReceiveEMail'} eq "") || ($in{'Picture'} eq "") || ($in{'Comments'} eq "")) {
  # something was blank, return the error message
  &PrintHeader;
  print "$Header\n";
  print "<CENTER><H1>An Error has Occurred</H1></CENTER>\n";
  print "\n";
  print "<P>You did not fill in all the fields.  Please remedy this.</P>\n";
  print "</BODY>\n";
  print "</HTML>\n";

  # make a call to exit to end the script now, we had an error
  exit;
}

if (($in{'SenderEMail'} !~ /\w*@\w*/) || ($in{'ReceiveEMail'} !~ /\w*@\w*/)) {
  # It does not equal the regular expression, send an error message
  &PrintHeader;
  print "$Header\n";
  print "<CENTER><H1>An Error has Occurred</H1><\CENTER>\n";
  print "\n";
  print "<P>Your email address did not contain an @ sign.  Please remedy this.</P>\n";
  print "</BODY>\n";
  print "</HTML>\n";

  # make a call to exit to end the script now, we had an error
  exit;
}

# Now write the info to the file

srand ();
$RandNum = int(rand(100000));

$Time = time();
$in{'Comments'} =~ s/\t/ /go;
$in{'Comments'} =~ s/\n/<BR>\n/go;

open (POSTCARDS, ">$BaseDir/$RandNum+$Time");
&lock(POSTCARDS);
print POSTCARDS "$in{'SenderName'}\t$in{'SenderEMail'}\t$in{'ReceiveName'}\t$in{'ReceiveEMail'}\t$in{'Picture'}\n";
print POSTCARDS "$in{'Comments'}\n";
&unlock(POSTCARDS);
close (POSTCARDS);

# Now e-mail the receiver

open(MAIL, "|$mailprog -t") || die "Can't open $mailprog!\n";
print MAIL "To: $in{'ReceiveEMail'}\n";
print MAIL "From: $SiteEMail\n";
print MAIL "Subject: $CardSubject\n\n";
print MAIL "Hi!  You've been sent a digital postcard from $in{'SenderName'}!\n";
print MAIL "To retrieve your full color postcard at no charge, simply connect to $SiteName at the URL below\n";
print MAIL "and it will be promptly delievered to your web browser!\n\n";
print MAIL "     Postcard URL: $PostcardURL?$RandNum+$Time\n\n";
print MAIL "Enjoy your digital postcard!  And feel free to send someone else one!\n\n";
print MAIL "Sincerely,\n\n";
print MAIL "$SiteName\n";
close(MAIL);

&PrintHeader;
print "$Header\n";
print "<center><h1>Postcard Sent Successfully!</h1></center>\n";
print "Thank you for using Casierra's Digital Postcards!  An e-mail notification was sent to the following address, notifying the receiver how to retrieve the digital postcard.<p>\n";
print "<p>\n";
print "<center><b>Receiver Name: </b>$in{'ReceiveName'}<br>\n";
print "<b>Receiver E-Mail: </b>$in{'ReceiveEMail'}</center><p>\n";
exit;

}


else {
	# Show the postcard
	
	$Postcard = $ENV{'QUERY_STRING'};
	if ($Postcard eq "") {
		&PrintHeader;
		print "$Header\n";
		print "You did not enter the entire URL for the postcard.  Please check the e-mail you received and make sure you entered the full URL.<p>\n";
	}
	
	if (-e "$BaseDir/$Postcard") {
		open (POSTCARD, "$BaseDir/$Postcard");
		$Data = <POSTCARD>;
		@Comments = <POSTCARD>;
		close (POSTCARD);
		unlink ("$BaseDir/$Postcard");
		
		# Now display the postcard to the user

		@Temp = split (/\t/, $Data);
		
		&PrintHeader;
		print "$Header\n";
		print "\n";
		print "	<P><TABLE WIDTH=\"500\" BORDER=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\">\n";
		print "	<TR>\n";
		print "	<TD><TABLE WIDTH=\"100%\" BORDER=\"1\" CELLSPACING=\"0\" CELLPADDING=\"0\">\n";
		print "	<TR>\n";
		print "	<TD BGCOLOR=\"#ffefdf\"><TABLE WIDTH=\"100%\" BORDER=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\">\n";
		print "	<TR>\n";
		print "	<TD VALIGN=\"TOP\" WIDTH=\"44%\"><CENTER><IMG SRC=\"$Pictures/$Temp[4]\" ALIGN=\"BOTTOM\"></CENTER></TD></TR>\n";
		print "	<TR>\n<TD VALIGN=\"TOP\" WIDTH=\"55%\"><CENTER><H2><FONT COLOR=\"#B31202\">$SiteName Digital Postcards</FONT></H2>\n";
		print "\n";
		print "	<P><TABLE BORDER=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\">\n";
		print "	<TR>\n";
		print "	<TD><P ALIGN=RIGHT><B><FONT SIZE=-1>From:</FONT></B></TD>\n";
		print "	<TD><a href=\"mailto:$Temp[1]\">$Temp[0]</A></TD></TR>\n";
		print "	<TR>\n";
		print "	<TD><P ALIGN=RIGHT><B><FONT SIZE=-1>To:</FONT></B></TD>\n";
		print "	<TD><a href=\"mailto:$Temp[3]\">$Temp[2]</A></TD></TR>\n";
		print "	</TABLE>\n";
		print "	</P>\n";
		print "\n";
		print "	<P>@Comments</P>\n";
		print "	</TD></TR>\n";
		print "	</TABLE>\n";
		print "	</TD></TR>\n";
		print "	</TABLE>\n";
		print "<center><h2><a href=\"$SiteURL\">CONTINUE...</h1></center></a></center>\n";
		print "	</TD></TR>\n";
		print "	</TABLE>\n";
		print "</BODY>\n";
		print "</HTML>\n";
		exit;
	}
	else { # Postcard doesn't exist
		&PrintHeader;
		print "$Header\n";
		print "<center><h1>Error: Postcard Does Not Exist!</h1></center>\n";
		print "Sorry, the postcard you have requested does not exist.  Please check your e-mail notification and re-enter your URL.  The postcard is automatically deleted once it has been read.<p>\n";
		print "</body>\n";
		print "</html>\n";
		exit;
	}
}
		
	

#######################
# Parse Form Subroutine

sub UnWeb {

   # Get the input
   read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

   # Split the name-value pairs
   @pairs = split(/&/, $buffer);

   foreach $pair (@pairs) {
      ($name, $value) = split(/=/, $pair);

      # Un-Webify plus signs and %-encoding
      $value =~ tr/+/ /;
      $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
      $value =~ s/<!--(.|\n)*-->//g;

      if ($AllowHTML != 1) {
         $value =~ s/<([^>]|\n)*>//g;
      }
      else {
         unless ($name eq 'Comments') {
	    $value =~ s/<([^>]|\n)*>//g;
         }
      }

      $in{$name} = $value;
   }

}

sub PrintHeader {
	print "Content-type: text/html\n\n";
}


sub lock {
 local($file)=@_;
 $LOCK_SH = 1;
 $LOCK_EX = 2;
 $LOCK_NB = 4;
 $LOCK_UN = 8;
 flock($file,$LOCK_EX);
 seek($file, 0, 2);
} #lock

sub unlock {
 local($file)=@_;
 flock($file,$LOCK_UN);
} #unlock

