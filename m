Return-Path: <linux-wireless+bounces-4371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABB18719C3
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 10:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351171F22736
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7358A54770;
	Tue,  5 Mar 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HukG+SWd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32555337B
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631694; cv=none; b=g3iViQ84SszBck8NPI8aMBowQ2FAatZbcDyyIZcSL9VEFvnDDD7+ulIP3aITdhgyVGk5XmxUNrYe6OSGQZdbERXtAohWh8ZuprxTi59Rnug36n4vEhhuJYVoar9prKpZ8uJGRP61xieVbz/oj/L8ahQ56qYDUo2R5we9VsxMRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631694; c=relaxed/simple;
	bh=IUnpRePB2qmDApx3ZXS/Z8cYNSwa2wNlhuDzjTTh9GE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MeT8zlrmxjY8uDYiafk2bcXQ5PAwbaNSEeymPd5aVPPwZt+20aFoWXF3MJVPJf/wk5foWDdtLi74AmzD5kpC7CipyM2IA+bnU3D6wEVxdHDKHE6JWaUtn0/gwPEBw6om/G1H9lhI9v5UxKdLVxSGlDNsMg3aa269e2fZavyVSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HukG+SWd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/U/NADY2mgCHejwOLhZFCF08saicDpvQ+0oneD79spM=;
	t=1709631690; x=1710841290; b=HukG+SWd4DxBAnDV8ynSBF/M7WfXmJhRd0ZWRDfBvj2hbxp
	jvJy8T31LGR+fGsDS8mf+THxWbLuM9AhNiYPh8dyxRccIE/YPrDPyBe7hMrwY6sUcVzfHrr5bPp+Y
	U7Sr7pG41P8TBJWCn40+7hhR+mU8JHsqdP2MYM/kDWVNAdGwm98UDhDsS3wsfsBlWNOsBOSXoZ402
	y1WywfOxy2DhJ2tfdhZDTw9uq8xem4iUaZqjD6MkRom33INeB8OMwXiRImkAzEgJmsFqZeZgaz+8Q
	BQX32DJgMw4lxtQ2bT1T0RqYdDLcu7YY0FgyZ5SvbuaqlITdrJJRJTLfF9wYYCJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rhRIc-00000002fnY-2xRQ;
	Tue, 05 Mar 2024 10:41:26 +0100
Message-ID: <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net>
Subject: Re: [PATCH v5] Add JSON output options to 'iw' for scan results
From: Johannes Berg <johannes@sipsolutions.net>
To: Isaev Ruslan <legale.legale@gmail.com>, linux-wireless@vger.kernel.org
Date: Tue, 05 Mar 2024 10:41:25 +0100
In-Reply-To: <5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com>
References: <5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-03-04 at 23:01 +0300, Isaev Ruslan wrote:
> v5 changes:
> 	- add json print to print_ap_channel_report()
> 	- minor refactor open_json_object()

Alright, yay, so mechanical submission issues out of the way, this looks
readable :)

> branch: v5.19

That's almost two years old, so you'll obviously have to rebase it on
the latest main branch. But we can have more fundamental discussions
first.

> This commit introduces the ability to output scan results from 'iw' in
> JSON format, similar to the 'ip' utility from the iproute2 package.
> The addition aims to enhance the tool's usability and scriptability
> by providing a structured data format option.

Generally, I'm not opposed to that, but I think we've had this
discussion before, and I don't want to see a lot of extra complexity in
the code for it.

> Two new command-line options are added:
> - '-j': Outputs scan results in compact JSON format.
> - '-jj': Outputs scan results in pretty-printed JSON format.


With tools like 'jq' being near ubiquitous, is there much value in
having two output formats? I'd almost say only support -j (and I don't
like '-jj' anyway, probably would prefer -j/--json and --json=3Dpretty or
so), and then 'jq' can do pretty-printing and coloring etc.?

> +	//close root json object and deinit jsonw
> +	if(iw_json){
> +		delete_json_obj();
> +	}

Please generally try to follow the (existing/Linux) coding style more
closely. I don't mind C99 comments but a space would be nice, space
after if, space before the opening brace, no braces needed here though,
perhaps more (just not on these four lines :-) )

> +++ b/json/json_print.c

I'm generally not going to look into these files for now, but including
them internally means we have to maintain them. I'd almost prefer a
library that can be used.

However, with that said,

> +/*
> + * json_print.c		"print regular or json output, based on json_writer".
> + *
> + *             This program is free software; you can redistribute it an=
d/or
> + *             modify it under the terms of the GNU General Public Licen=
se
> + *             as published by the Free Software Foundation; either vers=
ion
> + *             2 of the License, or (at your option) any later version.


This doesn't work well with the ISC license of iw. Which is another
reason to prefer an existing library, I suppose.

> +++ b/json/json_writer.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) //

We don't use SPDX license tags here yet, so not sure this is meaningful,
we also don't have a dir with the actual license texts like the kernel
has for instance.

If going this way it'd probably be useful to add SPDX tags to all
existing files too.

Here, off the top of my head, I suspect the BSD-2-Clause should actually
be compatible to releasing the whole thing under ISC, but need to check
that too.

> --- a/scan.c
> +++ b/scan.c
> @@ -12,6 +12,8 @@
>  #include "nl80211.h"
>  #include "iw.h"
> =20
> +#include "json/json_print.h"
> +
>  #define WLAN_CAPABILITY_ESS		(1<<0)
>  #define WLAN_CAPABILITY_IBSS		(1<<1)
>  #define WLAN_CAPABILITY_CF_POLLABLE	(1<<2)
> @@ -546,10 +548,13 @@ static int handle_scan(struct nl80211_state *state,
> =20
>  static void tab_on_first(bool *first)
>  {
> -	if (!*first)
> -		printf("\t");
> -	else
> +	if (!*first){
> +		if(!iw_json){
> +			printf("\t");
> +		}
> +	}else{
>  		*first =3D false;
> +	}

Coding style. Not sure why you don't just skip the whole thing if json
is turned on?

>  static void print_ssid(const uint8_t type, uint8_t len, const uint8_t *d=
ata,
>  		       const struct print_ies_data *ie_buffer)
>  {
> -	printf(" ");
> -	print_ssid_escaped(len, data);
> -	printf("\n");
> +	if(!iw_json){
> +		printf(" ");
> +		print_ssid_escaped(len, data);
> +		printf("\n");
> +	} else {
> +		print_ssid_escaped(len, data);
> +	}
>  }

Might be more useful to provide a JSON-output for SSIDs? Surely you'd
also want to escape them in a JSON-compatible way, since you'd want to
use '\uXXXX' encoding to actually get proper bytes out on the other side
without a special decoder?

> @@ -574,21 +583,35 @@ static void print_supprates(const uint8_t type, uin=
t8_t len,
>  {
>  	int i;
> =20
> -	printf(" ");
> -
> -	for (i =3D 0; i < len; i++) {
> -		int r =3D data[i] & 0x7f;
> +	if(iw_json){
> +		open_json_array("array", NULL);
> +		for (i =3D 0; i < len; i++) {
> +			int r =3D data[i] & 0x7f;
> +			if (r =3D=3D BSS_MEMBERSHIP_SELECTOR_VHT_PHY && data[i] & 0x80){
> +				print_string(PRINT_JSON, NULL, "VHT%s", data[i] & 0x80 ? "*" : "");
> +			} else if (r =3D=3D BSS_MEMBERSHIP_SELECTOR_HT_PHY && data[i] & 0x80)=
{
> +				print_string(PRINT_JSON, NULL, "HT%s", data[i] & 0x80 ? "*" : "");
> +			} else {
> +				print_string(PRINT_JSON, NULL, "%d.%d%s", r/2, 5*(r&1), data[i] & 0x=
80 ? "*" : "");
> +			}
> +		}
> +		close_json_array(NULL);
> +	}else{
> +		printf(" ");
> +		for (i =3D 0; i < len; i++) {
> +			int r =3D data[i] & 0x7f;

So generally, here, no - I don't like this style of working at all. We'd
really want to have as little "if (iw_json)" as possible in the code. In
code like this, we really shouldn't have such an if at all, but only
e.g.

  open_json_array();
  for (...) {
    if (...)
      print_string(...);
  }
  close_json_array();

Surely we can come up with an abstraction where something like
print_string() does the right thing either way? And open/close JSON
array does the '\n' needed after it, or something?
Maybe we'd pass an argument to open_json_array() that says how we want
it printed in the non-JSON case (and rename it to open_array?), e.g.
should it all be on one line like here, or should it be multiple lines
with " - " prefix on each line, etc. JSON also tracks nesting, I guess,
so we could even do that for nested stuff in the normal output where we
use tabs etc.?

Generally, I'd also say that we never promised stable output, so if the
output changes slightly due to such, I'm perfectly fine with that,
whoever relied on it (and that includes me in some internal code) gets
to keep the pieces when it breaks ...


Also, looking at the function calls, all those NULL and PRINT_JSON are
pointless, as far as I can tell? So I think it'd make more sense to come
up with a JSON-supporting but otherwise agnostic API abstraction:

 open_array(SINGLE_LINE); // could also be MULTI_LINE
 for ...
   print_string("VHT%s", data[i] & 0x80 ? "*" : "");
 close_array();


Maybe open_array returns some kind of token that you pass to the inner
calls down to close_array(), or maybe it just keeps a stack of these
internally, I could see either way working (though an internal stack
would probably be simpler to use, and with a lot of code using it, that
might make sense for to trade off against the additional internal
complexity)


Somewhat unrelated to that discussion, you might also want to not
actually use print_string() for rates here though, and possibly use a
different JSON encoding for the rates (and membership selectors), e.g.
as an object with a 'basic' property? But I don't care much about that
part, though generally I'd argue strings shouldn't be used where there's
a better representation with native JSON types.


> +	if(iw_json){
> +		print_string(PRINT_JSON, "capabilities_raw", "0x%02x 0x%02x 0x%02x 0x%=
02x 0x%02x", data[0], data[1], data[2], data[3], data[4]);

That's a really bad JSON representation, a string with bytes, rather
than an array of bytes?

>  static void print_erp(const uint8_t type, uint8_t len, const uint8_t *da=
ta,
>  		      const struct print_ies_data *ie_buffer)
>  {
>  	if (data[0] =3D=3D 0x00)
> -		printf(" <no flags>");
> +		iw_json ? print_bool(PRINT_JSON, "no_flags", "%s", true) : printf(" <n=
o flags>");

It seems like you'd generally want to have a container for each of
these, so you have

 // probably these two lines outside of the print_erp() call even
 open_json_object("erp");
 print_u8("tag", type);

 print_flags(...);

or something, rather than including "no_flags" in the object?

> +			iw_json ? print_string(PRINT_JSON, NULL, "WEP-40") : printf("WEP-40")=
;

This goes just along with what I wrote above, but that iw_json thing
here seems really pointless, and just makes things difficult.

(I also don't like the use of the ternary operator in this way but
that's maybe not quite the point.)

[snip lots of similar stuff]

>  	unsigned int bw160[] =3D { 5180, 5500, 5955, 6115, 6275, 6435,
> -				  6595, 6755, 6915 };
> +				6595, 6755, 6915 };

nit: unrelated whitespace change



So ... Like I wrote above, generally I'm not against doing this. But
like I also tried to explain above, I think it needs to be less
"duplicative". I'm happy to change the code in major ways to make JSON
output easier, I'm also happy to let that change the output in some ways
(maybe the default should be YAML-compatible ;-) ).

But I'd really want to see this done in a way that doesn't end up with
having to duplicate everything all the time.

We'll also need to figure out the licensing situation, and perhaps
ideally find a way to not add ~1.5k LOC to support it, but link against
something that exists already.

johannes

