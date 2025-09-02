Return-Path: <linux-wireless+bounces-26931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E7B3FC5B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 12:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869FD2C40F9
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20015283FD8;
	Tue,  2 Sep 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DuCT4S6Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9C283FC4
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808754; cv=none; b=hWHyOHdgaReLaEaLCUY4BiWu/Vqno8mgOc0x3EHMWxR26gSWWEAGwaoHLHbxG9STXaIfiTNRZKf02hXj7V2bD4WA0tRcmxOsaa7YUwClsz0T0D6xlYr8m1sgkzDZwq00LydKflimsPKJBFfpl9z3+30IWAhxj2uj9YvdSGLnL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808754; c=relaxed/simple;
	bh=8wzwhfdz1biLzrNTOQ25rigBF3LHkGZKoZZxOvqxVkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cNGyXQJM1j2Ikne1G5vCE+o5aYo8CGJjR1wEVaCVAa49woxoiv++QbTDIBkFwfZr347+TLvIT+jp3lxxW6+e7xhFu/wFBr9gZKY88B6GzuzZ2Utm8m7q0V54JFbsQJZ9C3UTQGJ9tRcx958IlqrWMqwDoC/0kEJAlYDJhhb4+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DuCT4S6Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=t9uI9WUgLxHyZns3qIEF8YCWdv0DJ5NJYckmBY0NrHU=;
	t=1756808752; x=1758018352; b=DuCT4S6YV86732+7blxXRGgHKiCzLrAGZp0rCcKZB9VS//1
	CE8OhL+WgoO9J33aYkRa3/GnpwbvVAmkiqNw4p+VxZ90IUtUV++41Gzx+AFmb/g1Sh7xJQgy8qGjW
	YWiIqDW1G/ouRlNAH2j3Ik7GuKAxT0D2WdihbU3nIuCIDUC65RXMKrkZ1DWPEnly0G/hnHnDE/xbd
	UACaiPMfOkUndNAhf8dY61oqcOCW7nCSucdyz5UcIx9LPSq14YRH/CzcZF5HxPQiK2THMmz17vju9
	PKiSc6F+96666F9SRKNOaoZm9DqlvLpIxvIznLkC1X7UVKyXO2k7iiv8pVO+Ktiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1utOCz-00000008c0F-3GtU;
	Tue, 02 Sep 2025 12:25:50 +0200
Message-ID: <0ef0467d3fc3695efe7f055147347234144592cc.camel@sipsolutions.net>
Subject: Re: [PROPOSAL RFC] S1G Primary Channel Implementation Proposal
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 02 Sep 2025 12:25:49 +0200
In-Reply-To: <s56cbux4fcydxoiqu3r3jhmxyvda2c6sdayhamks3d2ey2l3sr@6m5kaxhgpwvm> (sfid-20250902_101439_390675_FF2518D9)
References: 
	<xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw>
	 <75245df8edd5bbaa8f9cdfd12bab37720473d93d.camel@sipsolutions.net>
	 <s56cbux4fcydxoiqu3r3jhmxyvda2c6sdayhamks3d2ey2l3sr@6m5kaxhgpwvm>
	 (sfid-20250902_101439_390675_FF2518D9)
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

On Tue, 2025-09-02 at 18:14 +1000, Lachlan Hodges wrote:
> > Consider the difference between AU and US in the regdb (the only
> > countries currently listed with S1G support):
> >=20
> > country AU: DFS-ETSI
> >         (915 - 920 @ 4), (1000 mW)
> >         (920 - 928 @ 8), (1000 mW)
> >=20
> > country US: DFS-FCC
> >         (902 - 904 @ 2), (30)
> >         (904 - 920 @ 16), (30)
> >         (920 - 928 @ 8), (30)
> >=20
> > I'm not sure which operating class you're applying to get those channel
> > numbers in your figure above, so I'm going to have to handwave a bit.
> > But assuming such a restriction also applies on the lower band edge
> > (OFDM is symmetric, so it probably should) then you'd have to disable
>=20
> The restrictions are not necessarily symmetric as adjacent bands may have
> different limitations.

Oh OK, so it's a bit more complex than what it seemed earlier, but that
makes sense.

> > different channels in AU and US regdomains, since one starts at 902 MHz
> > and the other only at 915 MHz. So for a channel that's between 915/916
> > MHz (which according to your figure I guess would be channel 27?) you'd
> > probably have to disable it in AU but not disable it in the US?
>=20
> For what it's worth, our current hardware does not disable AU channel 27 =
as
> the emissions restrictions make it usable, but upper channels (eg 51) are=
=20
> disabled.

Right.

> > So I'm not sure statically disabling the channels from the driver works
> > unless you assume there's no regulatory domain involved or anything?
> >=20
> > If I'm right about this, then perhaps it should be expressed as a
> > (wiphy-specific) "primary channel band edge distance"?
>=20
> Currently our existing driver queries the disabled channels from a binary=
 blob=20
> passed to chip firmware on initialisation/reg notification. This isn't qu=
ite a=20
> complete regdom.

Right, I was more thinking if you know this device is now operating in
AU then things might change.

> Our expectation for a future upstream driver would be to statically
> advertise the entire set of potential supported channels, but to query th=
e chip
> firmware on initialisation or on reg notification so as to dynamically ma=
rk
> channels NO_PRIMARY when required. Sort of similar to what the rsi_91x dr=
iver
> is doing for NO_IR.

That works I guess.

> There are still issues with S1G channelisation that we will need to solve=
 later
> on (op classes, varying channel starting frequency etc.).

I'll go reply to your other mail too.

johannes

