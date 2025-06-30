Return-Path: <linux-wireless+bounces-24666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6FAAEDEE7
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 15:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DF93A1591
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 13:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B508243378;
	Mon, 30 Jun 2025 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dS7daHgR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD612522B6
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289681; cv=none; b=WSozHkiM/6kJ1pZV17mn6OXqICu0ahU0DXh/UWty0KLMxcFxFkkEf/QZUj1k/8N+h5EIzVgHLht9LSaM5PuLFv9q13+fD9U7SYyQNfZlHSSbReUPV8xoAjiaIYu+yCVpA+LNG2CdhTjDNu5j2g5/vQppORx0jUJ0zQrxBxdFEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289681; c=relaxed/simple;
	bh=zYe4cjPabOuRUub+QHwJtNEwLEuE25UXE6C1ayUhmVU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H9JX0ZCiCBfPlsgn/CFgnl/8ERg78jSul5HQfyAUSD7xXZWyZKkJEbhsslpC6j4W5bVe3/6bx116R74nUEZRTYR6ANrjYe4+I1pBmC9ssnbllDSsYhs2bcqdZOnKgw0dHvn6iiszY+0bTcpth+ALAjka1ny2WkkwV0JxBU7CO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dS7daHgR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zYe4cjPabOuRUub+QHwJtNEwLEuE25UXE6C1ayUhmVU=;
	t=1751289679; x=1752499279; b=dS7daHgRsf9v+Zeh90Bor8jYIpzg9MkaFOix1f9dmrMebeI
	baq3Ae8/ALfLOxjZQrltc8rb6Qv5jOX5ncXG7tKVeVPaw85iE9DD4JIi2sk7KtmHsDxHTaMuu+RWm
	QIbry6YOiLqAJI6hqvWeyyVjPXmCzouSRrqKqD9Yz54up+xrKZwnaYf7XMBpIgxd4C34yf11mNlHQ
	v8srracgYQxpn4ZIbc4F69jhBka1eV4/JcfkMlEzu4F5SP3afnOBdKbkUc+v+aogzc+YjYP6LiRHO
	a81qQrCH+0aY9CDEXk4zwon0ZOfzcf7wurilTODl0KDhihOqEhODD4nkKKN87Hdw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uWERf-00000001LGD-2l9m;
	Mon, 30 Jun 2025 15:21:15 +0200
Message-ID: <61d6cdebee2c89e5d2d93d3297c94051efb70790.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 0/3] wifi: Preamble puncturing support for
 mesh
From: Johannes Berg <johannes@sipsolutions.net>
To: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Ramasamy Kaliappan
	 <rkaliapp@qti.qualcomm.com>
Date: Mon, 30 Jun 2025 15:21:14 +0200
In-Reply-To: <21b7d547-b550-23a9-3bff-1f1787e307a8@oss.qualcomm.com>
References: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
	 <a8ff80ff5a811a09cf5556e20c7232eb1e201c2b.camel@sipsolutions.net>
	 <21b7d547-b550-23a9-3bff-1f1787e307a8@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-06-27 at 19:49 +0530, Ramasamy Kaliappan wrote:
> > I ... don't really understand how this is supposed to work.
> >=20
> > Say, for the sake of simplicity, we have an 80 MHz channel, the lowest
> > channel is the control channel (so puncturing 0x1 is invalid). Possible
> > puncturing values are 0x2, 0x4 and 0x8.
> >=20
> > If locally we have 0x2, that means (I assume, since that's how chandef
> > is meant to work) CCA and RX is always on the control channel and upper
> > 40 MHz parts. If you're now going to transmit to a station that has
> > puncturing 0x8, you didn't do CCA on the 0x2 subchannel, but ...
> > transmit anyway?
> >=20
> Yes,we do not transmit blindly to mesh peers with different puncturing.
> Before initiating transmission, the driver computes the intersection of=
=20
> the local and peer puncturing bitmaps to determine the set of valid sub=
=20
> channels.

Hm, I guess that's fair, but why not do that in mac80211 instead, that'd
be simpler and far more obvious/safe?

Also, clearly your driver _doesn't_ do what you say "the driver" does,
if anything it magically and "undocumentedly" happens in firmware.

> > I mean, maybe this could work if the remote puncturing is a superset of
> > the local puncturing? But just blindly doing it the way it appears to b=
e
> > done in this patchset seems ... questionable at best?
> >=20
> > Can you explain more how this is even supposed to work?
> >=20
> When associating with a mesh peer, the mesh peer's puncture pattern is=
=20
> shared with the driver. The driver evaluates the intersection of this=20
> bitmap with local pattern.

Could also be done in mac80211, I guess.

> if the resulting pattern corresponds to valid transmission bandwidth,=20
> the valid subchannels used for transmission.
>=20
> If the resulting pattern does not support a valid bandwidth, the driver=
=20
> falls back to using only the primary 20 MHz control channel for=20
> transmission.

Right.

I also note that there's not even any definition where the puncturing
pattern is rooted ... is it relative to the local chandef? Relative to
the peer's chandef? Clearly not even that is documented. What happens if
the bitmap changes? Why does userspace track it rather than mac80211,
which has the beacon of the peer and handles CSA, so what happens with
puncturing in CSA?

Did you think about any of these questions, or are you just using me as
a design tool? ;-)

johannes

