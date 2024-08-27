Return-Path: <linux-wireless+bounces-12082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA2961465
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3391282EBF
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA551CDA24;
	Tue, 27 Aug 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="A0JWpl9r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F01CDFC4
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776919; cv=none; b=WnwZEJRzW5qRF3IoOQ9qZDiM+gznOSf17bpY0gS7NSfl01zH+PvQWHtSm4twAIZjWuliHUG2S8sOX6PjJKbqRqhgqzNBcN5rpWVARk9wpz2DA2GcdXQJf/55h5CK5XX8SOfEIQfav+6ET+2cF/HrXGVdRhlnPzyxshJPf5R/314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776919; c=relaxed/simple;
	bh=xmUfMCmXb259Kn1fkQHXGEFOAKQW/d2b9FYmCNK+J38=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WE58sXZU7fMFp8DQUJwvLklRLGT4yI4tMcI/WVLfWtc7Wbkvz1/LI2QyWClj+oyDPWwZ+txDTFqXF/CD+LvkoDLJHSEJbF3YuVZqgeoHzQgP8evTcjK2evNJoTUIYTLSRl0mKJGtE2+eZkUnlI4cC3n7HWzOwBLedvBmKRh1uyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=A0JWpl9r; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w3NMz6GdrgRVUmJxFWUx2AIoStq1EY0YyDOA58QepLE=;
	t=1724776908; x=1725986508; b=A0JWpl9rOpO6trBDN3PwJRBx5r8Yp+LeqHLLGY+P/tmQXOr
	PM96U04sgL18ECCivRbYBMFhbLAk8V/eh0FXciwvYDcIiHdeqy8Kq6/DWYdkDcZIydQcODzPVpx6H
	VAsGNpu8ViosELvy2Yg8MjpU64tRZJYwKvHNQFCgD4Jzb7NHGYix+spOoa7tRjAjGZkhxC+K1s8+q
	TB1vw3QsAQUhbbwLlmJ8+aqtTss2SRvzeaQ096aA//0x6vTdPUBVQBfPqjF/QPD5EMRWFqx2drbDg
	xP7qsFM6r9vakv/lZ3ixJO5pQXmF/ay0J4+IWkfXNt+YTXmHEWssJEq6jmNjj9kA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sizGL-0000000544U-2mR1;
	Tue, 27 Aug 2024 18:41:45 +0200
Message-ID: <b00a52947670f45c0764d33ea093c90b825fcdab.camel@sipsolutions.net>
Subject: Re: Per MLO link TX stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 27 Aug 2024 18:41:44 +0200
In-Reply-To: <41008ac0-ca36-b19f-c3a4-61f54ce2d2f7@candelatech.com>
References: <c896c0d6-b43f-ba6d-336a-eca15c60529f@candelatech.com>
	 <7ccb9c8ccb0dd16539ac064a35d6bf6b31d0bf0d.camel@sipsolutions.net>
	 <e5c3265a-3411-39b4-f4c4-40f3937c96fb@candelatech.com>
	 <9093726e308d0a26e8afe2323a865d222e48fe61.camel@sipsolutions.net>
	 <41008ac0-ca36-b19f-c3a4-61f54ce2d2f7@candelatech.com>
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

On Tue, 2024-08-27 at 09:28 -0700, Ben Greear wrote:
> On 8/27/24 09:20, Johannes Berg wrote:
> > On Tue, 2024-08-27 at 09:12 -0700, Ben Greear wrote:
> > >=20
> > > When be200 goes into eMLSR mode, both 5 and 6Ghz links are shown as a=
ctive, so at least
> > > you cannot use 'active link' to reliably update stats.
> >=20
> > Sure, not active link - but there's an LMAC bit somewhere ... Ah, it's
> > not documented, it's actually documented *differently*, but it should b=
e
> > bit 31 in len_n_flags in struct iwl_rx_packet.
> >=20
> > Given the LMAC ID on the TX response notification we should know which
> > LMAC transmitted it, and then I think it's a simple mapping to the
> > active link. But I haven't actually really tried it.
>=20
> If you can share a patch that documents this bit (like 0 means 5Ghz and 1=
 means 6Ghz??)
> then we can try it out.

I think yes, 5 GHz should be on LMAC 0 and 6 GHz on LMAC 1, and that's
the only case where we can have two active links simultaneously.

There's still a race though, when we change the active links while
transmitting, not sure how to handle that.

Oh wait, it's simpler than that - we have the STA pointer in there
already (see iwl_mvm_rx_tx_cmd_single and iwl_mvm_rx_tx_cmd_agg), but
since we get that from the FW STA ID, we obviously also know the *link*
STA since the FW STA IDs are per link, so we can just go from there to
the link ID directly.

link_sta =3D rcu_dereference(mvm->fw_id_to_link_sta[notif->sta_id]);

link_sta->link_id

> And maybe your idea for how to report it in tx-status too since that will=
 touch
> mac80211?

I hadn't really thought about that ... I guess we could use the
IEEE80211_TX_CTRL_MLO_LINK space also for status? It's already filled to
the link ID by mac80211 for TX if the frame must go out on a specific
link (or 0xF otherwise which is an invalid link ID anyway.)

> > > > > In the case where there is a single active link, then I can hack =
something together
> > > > > that should be at least mostly right, but that won't fix any futu=
re radio that can
> > > > > do 2+ active links.
> > > > >=20
> > > > > Any suggestions for best path forward on this?
> > > >=20
> > > > I really think we also need to do some work on the API/cfg80211 lev=
el,
> > > > and have link station statistics in cfg80211 instead of full statio=
n,
> > > > and then combine them to (older) userspace in cfg80211, i.e. if
> > > > userspace doesn't request broken out per-link statistics. There's
> > > > probably a bunch of work here, and I only have a vague idea of how =
it
> > > > should be done...
> > >=20
> > > I think first step is to get the driver(s) able to report the link-id=
 in
> > > the tx-status.  After that, mac80211 can gather the stats.
> >=20
> > Yeah, that makes sense, at least partially that's needed. I suspect tha=
t
> > also we need to extend the API down to the sta_statistics call though t=
o
> > return per-link statistics, e.g. the TX bitrate would seem should be
> > reported per link, and that's done through that call now I believe.
>=20
> Yes.  At least at cfg80211 level, I think we should be able to query all
> link stats in a single call into mac80211.  Down in mac80211, then per-li=
nk
> stats structs appears to be how things are done now and seems like a good
> solution.

Not sure I have a strong opinion on this being a single call or not,
either way seems reasonable really.

> >=20
> > > I hacked
> > > tx/rx link stats into mac80211 ethtool (for first 3 links), but it is=
 still not reliable since
> > > mac80211 doesn't know the actual tx link id.
> >=20
> > Right.
> >=20
> > > After that, then certainly I'd be happy to have per-link stats availa=
ble,
> > > and combining them in cfg80211 seems like a fine idea as well.  Some =
things
> > > that don't combine well (rssi, link rates, etc) would take a bit of k=
ludging
> > > if trying to provide a single 'sta' view of stats.
> >=20
> > True, some can't just be added up and we'd have to find a sane differen=
t
> > "best" view, perhaps for rates it'd be the better of the two or the sum
> > if only reporting the bitrate, or better of the RSSI, etc. Case by case=
,
> > I guess.
>=20
> I'd suggest using highest active band when we have no better option for
> summing/combining.

But is that the most useful thing? What if the RSSI is quite bad there
(but still good) and then NetworkManager shows a really weak signal when
in reality you have a good connection on another link? Anyway, dunno,
we're not near that bridge yet I think ;)

johannes

