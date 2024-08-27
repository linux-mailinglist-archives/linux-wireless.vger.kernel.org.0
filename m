Return-Path: <linux-wireless+bounces-12074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366A99613DB
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7203D1C232EC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A161C5792;
	Tue, 27 Aug 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="niSaHEjS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3B2E62C
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775622; cv=none; b=tV2rShO7C52loGAWFF5kCF4GJkku5ZCSl+sCocWuiUor1687a5ZpIMI+R76/h1loGPuGQPv6X6UuNm6/2Ke2SOkkptL0V2f5Hjs+21hngzeXfAIr9qXWxOEnS2JAm8i8WOcwaim3ucQ7s7SkkC46bD1tgmnyRoob/AQRVLEvrSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775622; c=relaxed/simple;
	bh=/qqcaRs0sDftnDZWAkPLI5v9fqZkk+yObyz2GnP1Agc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ljz6owH7qtPSfTwCzywMbNwtUxwrsQR0nYhbJKSv3Dh8o7YK9X++/mF+OYVyEDNx/X6x3oGFeMvDXCCs/FEZR43mNUl6owL029lxuBhHdsFb4Wb/NVgBeMmbmoJpGHEHYki++L6Qeo6ueLAggVv8my/gtBKRfsG6TzzNJUbE2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=niSaHEjS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hhCrOPM4RoLycSHQr9hDQKasTq0KSQKDbPc6ByqG1nc=;
	t=1724775621; x=1725985221; b=niSaHEjScSg+Hn4IMmgX9XUVXbpbfje8TdhoTsWi6iQ509T
	1FJgPyTD/tr3JaIneEYN7aJPOFaAVhzeMFoW5ASgjPOhTYKRHMxUc+hxET74IRXq8cerXdsVfHD6s
	cCowBJH0IRlpoiCmkIAtSsrzKbBIug2CyquBo6irJ8vf7ebYhW+qGyfOLbxiwyx04rnB6FsGyxbhO
	Hzt4zdbZ1fZeGNkD1BdYbq59aHunkWpbJE/TmWBWDVVjAuiyqnUq4b2CBq3dMT37qGJgpKgUW/eJu
	Zp9ONqa7ha7szFgu3bR/UdvuEZRT5sO7ClW5CpXsYzdtoVXphrKPXHbFkcQHQy4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1siyva-000000052Qx-47Us;
	Tue, 27 Aug 2024 18:20:19 +0200
Message-ID: <9093726e308d0a26e8afe2323a865d222e48fe61.camel@sipsolutions.net>
Subject: Re: Per MLO link TX stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 27 Aug 2024 18:20:18 +0200
In-Reply-To: <e5c3265a-3411-39b4-f4c4-40f3937c96fb@candelatech.com>
References: <c896c0d6-b43f-ba6d-336a-eca15c60529f@candelatech.com>
	 <7ccb9c8ccb0dd16539ac064a35d6bf6b31d0bf0d.camel@sipsolutions.net>
	 <e5c3265a-3411-39b4-f4c4-40f3937c96fb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-08-27 at 09:12 -0700, Ben Greear wrote:
>=20
> When be200 goes into eMLSR mode, both 5 and 6Ghz links are shown as activ=
e, so at least
> you cannot use 'active link' to reliably update stats.

Sure, not active link - but there's an LMAC bit somewhere ... Ah, it's
not documented, it's actually documented *differently*, but it should be
bit 31 in len_n_flags in struct iwl_rx_packet.

Given the LMAC ID on the TX response notification we should know which
LMAC transmitted it, and then I think it's a simple mapping to the
active link. But I haven't actually really tried it.

> > > In the case where there is a single active link, then I can hack some=
thing together
> > > that should be at least mostly right, but that won't fix any future r=
adio that can
> > > do 2+ active links.
> > >=20
> > > Any suggestions for best path forward on this?
> >=20
> > I really think we also need to do some work on the API/cfg80211 level,
> > and have link station statistics in cfg80211 instead of full station,
> > and then combine them to (older) userspace in cfg80211, i.e. if
> > userspace doesn't request broken out per-link statistics. There's
> > probably a bunch of work here, and I only have a vague idea of how it
> > should be done...
>=20
> I think first step is to get the driver(s) able to report the link-id in
> the tx-status.  After that, mac80211 can gather the stats. =C2=A0

Yeah, that makes sense, at least partially that's needed. I suspect that
also we need to extend the API down to the sta_statistics call though to
return per-link statistics, e.g. the TX bitrate would seem should be
reported per link, and that's done through that call now I believe.

> I hacked
> tx/rx link stats into mac80211 ethtool (for first 3 links), but it is sti=
ll not reliable since
> mac80211 doesn't know the actual tx link id.

Right.

> After that, then certainly I'd be happy to have per-link stats available,
> and combining them in cfg80211 seems like a fine idea as well.  Some thin=
gs
> that don't combine well (rssi, link rates, etc) would take a bit of kludg=
ing
> if trying to provide a single 'sta' view of stats.

True, some can't just be added up and we'd have to find a sane different
"best" view, perhaps for rates it'd be the better of the two or the sum
if only reporting the bitrate, or better of the RSSI, etc. Case by case,
I guess.

johannes

