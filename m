Return-Path: <linux-wireless+bounces-26960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D36B415BE
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 09:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98F5541F00
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA6B270578;
	Wed,  3 Sep 2025 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qLI4TEp/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D91F92E
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882895; cv=none; b=abAlzd4xnkXy+LQ0ETPOMiryNpK6WrCY+OaNlwz2kycYl8Sq0a5o/fOl/RFNwa2/ahQg1kI5gqg3u2n5gqRVp0qXhRRsNbsuZYIdB6EJGTbZ3lozf0hvALDQ0n5Wh0yERVfW7DjBfTHWJUPLCBRMOAdh2eip/xd+6gJlz90ME10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882895; c=relaxed/simple;
	bh=xeBlodgVIQm4ny9mLqWo+41yVM4Rwtv3XRDy8QTNeao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O0rcIfTVXU+DYnPjjbEqb/VDuv2cDGJEG8lk3/In8zVwXE8RDDNlCQ5kv4a2LWRFqfKXIPtN6SuHq7quYApm/joAO7lo78XbSKo0hUJCyxfYWFt7gt1j33Q3zwhljIuEYAbSn4MUSKyw1sejJDQaT4mswpqYjckTXXTzqQhIvK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qLI4TEp/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xeBlodgVIQm4ny9mLqWo+41yVM4Rwtv3XRDy8QTNeao=;
	t=1756882893; x=1758092493; b=qLI4TEp/4/RrVG1Y/DWtWCW9tlvdV0lJrylaKWR5/GdH7D6
	rxzMkfIEKBCR/Xj8fuev9wAFFkGvKpIaN7aY4Kme+d3Comh8tsP5xXd0dKcUVnz0+JTxvcaznFt2n
	pth35TQiO/w+OI7yCmsg+pwWz0PCfGvhIShwDY4o+gD0lPjX9iXFkN71X3/a4HHZ05WQJ8uEtfeXD
	3K5MjLO4dOTiPaYP1A1Ons5W2aPoNaOvISSZXLqscpC1Bm9aUYZmAWLHeirw6sSGbeSnIYn2FouWp
	ktUvSvoZi8Bt0VMGK9B0X2tWu16pvn1Lxu9CGxnP9S8G/4lDYAGH/51SmnN7r+dQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uthUo-0000000BQes-3yjy;
	Wed, 03 Sep 2025 09:01:31 +0200
Message-ID: <d1b9eefaf8dcd93dc5c9ba7efe63724e7ee23d35.camel@sipsolutions.net>
Subject: Re: [PROPOSAL RFC] S1G Primary Channel Implementation Proposal
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Wed, 03 Sep 2025 09:01:30 +0200
In-Reply-To: <byajqzqa2qqxh7l6kul7pxzt5rn74hiwln3rpkcfytqq6fw2ml@wszpdqibci4t> (sfid-20250903_043336_942244_BBFCD4AB)
References: 
	<xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw>
	 <75245df8edd5bbaa8f9cdfd12bab37720473d93d.camel@sipsolutions.net>
	 <czhftz5pdqx4edw4xr73svcr5cxfzzwa2r547p52tmsgywsb34@k5ooo5iw5mcu>
	 <9363e3a700565a34145be7268deb0a8623f659ba.camel@sipsolutions.net>
	 <ab4ea03131cec7847b31eb548881ef79da4ae1c5.camel@sipsolutions.net>
	 <byajqzqa2qqxh7l6kul7pxzt5rn74hiwln3rpkcfytqq6fw2ml@wszpdqibci4t>
	 (sfid-20250903_043336_942244_BBFCD4AB)
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

On Wed, 2025-09-03 at 12:33 +1000, Lachlan Hodges wrote:
> On Tue, Sep 02, 2025 at 01:36:02PM +0200, Johannes Berg wrote:
> > To maybe describe where I'm confused more clearly:
> >=20
> > > > * ->chan points to the primary 1MHz or 2MHz channel
> >=20
> > This was based on something I said. When I first read it it, I thought
> > this was because 2 MHz primary channel was a completely independent mod=
e
> > of operation of the two 1 MHz frequency ranges that make up this 2 MHz
> > range.
> >=20
> > But maybe that was wrong? Because you also said this:
> >=20
> > > > As mentioned, the one difference is that S1G primary channels can b=
e 2MHz.
> > > > The standard (and by extension, the S1G Operation element) uses the=
 notion of
> > > > primary channel location. When we have a 2MHz primary channel, the =
AP must
> > > > specify which 1MHz subchannel _within_ this 2MHz primary channel is=
 used.
> >=20
> > So this seems to indicate the primary channel is always 1 MHz?
>=20
> Not necessarily, in fact most cases we use a 2MHz primary when possible.
> In cases like this, beacons are transmitted on the center frequency of th=
e
> 2MHz primary channel (And I realise Im just saying "channel" again). This=
 is
> a composite of 2 1MHz subchannels and we then specify the location of the
> 1MHz subchannel and advertise this to STAs (This is done in hostapd anywa=
y,
> so not really a concern here). With the flag you suggested below, this is=
 fine
> though.

Right, sorry; I understood this better after looking at the spec, but
didn't go back and correct this part of what I wrote.

> Yes this works. If we have the s1g_primary_2mhz set to true we'd need to =
do
> some validation that both 1Mhz subchannels dont contain the NO_PRIMARY fl=
ag,
> but that should be fairly straightforward.

Right. There could also be a few other things to validate, but generally
with this as long as the primary 'chan' is within the range described by
center_freq1 +/- (bandwidth/2 - 0.5 MHz) the chandef should describe a
valid channel configuration, I think. If something else is needed we
always have chandef_valid(). Obviously it should be expanded to check
that s1g_primary_2mhz is only used for S1G :-)

Oh and I guess we'd need a new nl80211 attribute for that to configure
it on the AP side?

> These emails have been very helpful, will go ahead and draft the patchset=
 then
> probably send sometime next week for RFC.

Sounds good!

johannes

