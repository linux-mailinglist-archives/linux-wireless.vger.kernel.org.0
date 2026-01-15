Return-Path: <linux-wireless+bounces-30844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3904D24E66
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 15:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72D2930081B5
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4939E6C1;
	Thu, 15 Jan 2026 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="p6zRGlj5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDD30DEDC
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486691; cv=none; b=FPOnXkLj2k1uuvJYJ8A6sBidw4VPmgD6kWhC4XrNE3LxX0irTL6avz0H1OQoDWKvVnOzLusGT4LtfHahFp7IuxQuWzQj5Hqde3ywF5cfE9k2Ktkb5/GWjdSJx3yPEnlxQfuopeoLSjcgqKBOuZHw5YQsnNB0r7RPIygYT7xMDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486691; c=relaxed/simple;
	bh=YgTnJsTai7FjZCieWiXAib1IJbxoUGHkwkLU9+Ktvzw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jn7vfLC9n7r6o8e9PyAJIyR/oxBr00dEI7CNtk7n0wzm/JYCgrr9BjCvNPMDT8qI51ysMX3Y8fx7r0mrFTRsAKUysGb7XWa7lm682T+u98zSOn+FJSglPo4ZCTokLdvrTvxFC08w4q7Mc6tR+5Vv+bg4gfwkZxojUvV2W1Hyu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=p6zRGlj5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YgTnJsTai7FjZCieWiXAib1IJbxoUGHkwkLU9+Ktvzw=;
	t=1768486690; x=1769696290; b=p6zRGlj53y/b6NmyMrUMfNOvbTBFyP+JcE7zzMazWD9BZOx
	sBS57U4KD9p5cy1wLp8GUFR4E7q78Z4G705JCkgBaUOar+t7YGj3E9ESgloLaYKmk4xWLEObRatlS
	un7HttKNQ4H7MRp2WM6svf0BCVqDF8xHNr8+vdruv4ypSqPT+0BVhJJkqPYSO6wc3BtgBgo28EAHm
	1s1n6YfD/XSezVrrFO05uSLOmAPrR3DS7TLWFUc3nneTlJZf/Ob7BaWwid9SEq6I3C+eEYjJ+Sher
	d32tJ8R4HyMONHiHL6NZMNtvS++F9RpE7A6+pzvUtB67MO/cTB+1dnOYOgiPG9Hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vgOAh-0000000CYt3-3aTm;
	Thu, 15 Jan 2026 15:18:00 +0100
Message-ID: <52356be3d21920d84579d1a8fd803540c6f9644d.camel@sipsolutions.net>
Subject: Re: [DESIGN RFC v3] AP Architecture for Wi-Fi-8 Multi-AP
 Coordination (MAPC)
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Abhishek Rajkapur
 Suryawanshi <abhishek.suryawanshi@oss.qualcomm.com>,
 ath12k@lists.infradead.org, 	hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 Jan 2026 15:17:59 +0100
In-Reply-To: <63ff0362-4ee4-4f13-a212-dc1351eefe08@oss.qualcomm.com> (sfid-20260114_201523_158312_F45EB4BD)
References: <653a4207-38f8-408c-8067-c4960c11a71f@oss.qualcomm.com>
	 <05381371a41f154058429f0a1079204c4a454f45.camel@sipsolutions.net>
	 <59cec65b29ded381c85d1be943d88e956a4b7e74.camel@sipsolutions.net>
	 <63ff0362-4ee4-4f13-a212-dc1351eefe08@oss.qualcomm.com>
	 (sfid-20260114_201523_158312_F45EB4BD)
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

On Wed, 2026-01-14 at 11:15 -0800, Jeff Johnson wrote:
> On 1/12/2026 11:18 AM, Johannes Berg wrote:
> > On Mon, 2026-01-12 at 20:12 +0100, Johannes Berg wrote:
> > >=20
> > > Why do you always want to let firmware be in control of everything?
> > > Seems at least for some of this you'd really want the upper layers to
> > > control it for purposes of coordination? How does the FW even know wh=
ich
> > > other AP it can coordinate with, isn't that something a network
> > > controller would determine?
> >=20
> > A less generous reading of this could be: you guys want everything to b=
e
> > controlled by FW, so you don't have to open-source it in hostapd. Now
> > you realize oops, don't really want to do all the security handshake in
> > FW, so we need to ask hostapd and then we need keys and stations and al=
l
> > this stuff. So let's build something nobody else can use, upstream it
> > and we get the best of both worlds - others will maintain the mac80211
> > code for us anyway.
> >=20
> > Am I wrong? Is there a technical reason for not simply doing MAPC
> > discovery/agreement negotiation etc. in hostapd as well, based on
> > driver/hw/fw capabilities, and then you don't need all these strange
> > "triggered by firmware" flows?
>=20
> My perception is that Qualcomm would love for all the Wi-Fi 8 functionali=
ty to
> be in userspace and nl/cfg/mac80211 since then there would be no code
> maintenance overhead on our part -- just you and the userspace maintainer=
s.

:)

> But there are concerns about latency, and internal consensus is that some
> aspects of this functionality has to be handled in firmware (or even hard=
ware)
> in order to meet customer KPIs. This comes from our history of supporting
> large-scale deployments of APs, and the expectations of how Wi-Fi 8 will =
make
> things better. That is why we are posting design RFCs, so that you, as we=
ll as
> engineers from other vendors, can review our proposals and give your feed=
back
> and counter-proposals. We want to avoid developing what might be an
> architecturally pure design that doesn't actually meet customer needs.

Sure, that's fair.

Maybe I can just ask folks to spell out the constraints and reasoning
behind the design?

Taking this specific example, it basically says "FW sends a request to
hostapd, hostapd does the handshake and installs the MAPC station. This
is how we think we should handle the MAPC stations."

It never says _why_ and how any of this happens. What's the magic thing
only the firmware can do to figure out it should start coordinating a
given AP? (Clearly that operation can't be concerned much about latency
if it asks hostapd.)

In fact I'd have expected that in certain cases some controller
infrastructure sitting *on top of hostapd* would decide which APs
coordinate with each other, rather than the firmware. Although I guess
if you hear the beacon on the same channel with a good enough RSSI then
you can coordinate.

I could keep guessing - maybe there's a limited space to do this in FW?
But there's not even anything built into the design where the firmware
can ask to _remove_ it again, as far as I can tell, unless there was an
(unstated) assumption that it can just delete the MAPC station and send
a DEL_STATION notification about it.

The document even says that phase 1 is discovery, and then goes to
completely ignore phase 1 (it's hidden in FW), and describes basically
only phase 2.

> And apologies for the "firehose" of both design and code, but we have a d=
esire
> to ship Wi-Fi 8 products using upstream code. I've passed along informati=
on
> that you want our engineering team to focus on the base NPCA patches so t=
hat
> there is the appropriate foundation. But in parallel we do also hope ther=
e is
> engagement from other vendors on the Design RFCs we are posting. Our goal=
 is
> to upstream as much AP functionality as you can absorb.

Sure, and I appreciate that this is coming. I'm a little overwhelmed by
having so many parallel things going on right now, and all the parallel
design documents don't help.

Maybe this is the point where we consider inviting everyone who wants to
a room for a few days? Even a video room might be better ;-) List some
topics first, present the design briefly, etc.? But I don't know if it's
just the medium.

johannes

