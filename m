Return-Path: <linux-wireless+bounces-26935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 955A6B3FDE3
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 13:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9461B2474E
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 11:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651102F6176;
	Tue,  2 Sep 2025 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lb9Fmp6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB6F1CAA6C
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812967; cv=none; b=iLypbqJlF7pHmaXW2ge/6vfIDWB1UJNkEwzKUstw+potAuLkGVrHamRM2lpZsW6DyBbepj0Vl126s9/XHGAIW0YwH6JPXXOx9m47rBiJ2QPe/dPI3pOb0+Bh0ASlVpT25W+E6KlNuuDw0etjDFBMbLicsykiY+cuVrEO4N6DBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812967; c=relaxed/simple;
	bh=Qy08QyzoP2M8P1LwDKGKnN61gAFgMAFEa7XlX6dYzLk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqWdaClbvmBY4fVzFrgGG8gHBN0JpQmDYB5PU0ko804bjpvq/5+sFSdTvlCWvTklVYpeSKsHZtSCwjGCyOzQf9HgZAmu502gR+Kjl6I/KLrVxGKHMcUndZRZBKT3ULE09KlKJRytuLqZM4E3yKOgbRZM3/5TDnLln0w9ttWbo6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lb9Fmp6M; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BCA9M7aVKOugoRFra5D31KzPo1/saOm5iQj48HeXtaU=;
	t=1756812965; x=1758022565; b=lb9Fmp6MPCNKYlkXQPlfwDcKv4c4XokyheF2XagXgXkv0kE
	PcIRj4q+AfDldb7ukEnNmQ4ScQWM7dAkwle3/f5wcLtlBp8cYj633jJJ8gK1FDcu7ab/UZpxUYowQ
	UeoG1XRsWidvzeYTuglJx310bYm6FtvollknnbrO6cEWLIanBcYKcSlgtSJ/5tdoCzUt6WcTtJAWq
	O09cE0r7+vrwX+ioJH2mSugvDzOIlzIL6fbXnYx3Qm63L65wa+yyUtrga9zp1hMM6LhSrR2PWnE0S
	050onjJKMTBeXNbtr9QoEMIjKL6K1Yqf4C1k/52Q4/ao+pkvAjdfJ5GeLcNGPcLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1utPIw-00000008p44-3qXh;
	Tue, 02 Sep 2025 13:36:03 +0200
Message-ID: <ab4ea03131cec7847b31eb548881ef79da4ae1c5.camel@sipsolutions.net>
Subject: Re: [PROPOSAL RFC] S1G Primary Channel Implementation Proposal
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 02 Sep 2025 13:36:02 +0200
In-Reply-To: <9363e3a700565a34145be7268deb0a8623f659ba.camel@sipsolutions.net>
References: 
	<xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw>
		 <75245df8edd5bbaa8f9cdfd12bab37720473d93d.camel@sipsolutions.net>
		 <czhftz5pdqx4edw4xr73svcr5cxfzzwa2r547p52tmsgywsb34@k5ooo5iw5mcu>
		 (sfid-20250827_080037_104246_E84172B0) <9363e3a700565a34145be7268deb0a8623f659ba.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

To maybe describe where I'm confused more clearly:

> > * ->chan points to the primary 1MHz or 2MHz channel

This was based on something I said. When I first read it it, I thought
this was because 2 MHz primary channel was a completely independent mode
of operation of the two 1 MHz frequency ranges that make up this 2 MHz
range.

But maybe that was wrong? Because you also said this:

> > As mentioned, the one difference is that S1G primary channels can be 2M=
Hz.
> > The standard (and by extension, the S1G Operation element) uses the not=
ion of
> > primary channel location. When we have a 2MHz primary channel, the AP m=
ust
> > specify which 1MHz subchannel _within_ this 2MHz primary channel is use=
d.

So this seems to indicate the primary channel is always 1 MHz?

Looking at the spec, the S1G operation says you have _both_:
 - the primary width [B0]
 - the overall width 1/2/4/8/16 MHz [B1-B4]
 - the location of the 1 MHz primary inside the 2 MHz primary [B5]
 - the overall channel center frequency (as a channel number)

So something like Channel 44/8MHz with 1 MHz primary in the upper half
of the primary 2 MHz would be

 - primary 1 MHz	width B0 =3D=3D 0
 - 8 MHz		width B1-B4 =3D=3D 7
			(? Table 10-41 S1G BSS operation channel width)
 - primary channel num	38
 - channel center freq	44


But I don't think we necessarily have to capture this the same way in
our chandef.

We could also say that the 'control' channel pointer always points to
the primary 1 MHz. Then, we only need a single flag in the *chandef* to
capture the whole definition, in this example:

 - chan: pointer to struct ieee80211_channel for channel 37
 - width: 8 MHz
 - center_freq1: 925 Mhz (=3D=3D channel 44)
 - s1g_primary_2mhz: true

All the locations automatically follow, you just need a little bit of a
helper to calculate the "primary channel num" for the S1G operating
element, since that's now no longer obvious - but basically just

  if (!chandef->s1g_primary_2mhz)
       return channel_number(chandef->chan);
  BUG_ON(chandef->width =3D=3D 1MHz);

  ... depends on width and distance between chandef->center_freq1
      and=C2=A0chandef->chan->center_freq but I'm too lazy to write it down
      since that also depends on the _khz bits. something like

  diff =3D 1000 * chandef->center_freq1 + chandef->center_freq1_offset
       - 1000 * chandef->chan->center_freq
       -        chandef->chan->center_freq_offset;
  diff =3D abs(diff)

and then take the figure you had before into account:

>    |------|---------------------------------------------|*|
>  c | 8MHz |  |                  44                   |  |*|
>  h |------|---------------------------------------------|*|
>  a | 4MHz |  |        40         |        48         |  |*|
>  n |------|---------------------------------------------|*|
>  n | 2MHz |  |   38    |   42    |   46    |   50    |  |*|
>  e |------|---------------------------------------------|*|
>  l | 1MHz |  | 37 | 39 | 41 | 43 | 45 | 47 | 49 | 51 |  |*|
>    |=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D|*|
>    |******| 920  921  922  923  924  925  926  927  928 |*|
>    |******|---------------------------------------------|*|
>                            frequency (MHz)


That should work?


Then we also only need struct ieee80211_channel for each 1 MHz channel,
your thing with the regulatory "non-primary flag" also works more
easily?

johannes

