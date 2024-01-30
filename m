Return-Path: <linux-wireless+bounces-2804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FC48421DA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 11:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C85E1C2366D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 10:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840D664C1;
	Tue, 30 Jan 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="q/XqVzA6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683F657BF
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611610; cv=none; b=qsU1wSlmTfwRIq5qTtOZ03jJJEfB9YiVXDaZKcO+vHioZwMX97cPe7sjvNpwvOYzjQYBh75lU37FwYr4qDvFGr1IcSnsx9hxbuKaz/w+0Gc61W6//tQKqUChj4oo1XjhqizdfDp5JC1jx5QaZZ2D+9vgm3bL6YuS5Wod8qgCL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611610; c=relaxed/simple;
	bh=JhUuu/Yg9LUVFMzymfszOs0XLJug4O8wY3eURtQbDso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oww3NbKYc1vs4cYTNoT55NvxcnQGumP+8OZZBT3t8+Qh+moHIcdqhYjQ6KXGVw3Jc+q2FyFDvH2elguDID86RfRK45L2DNbKRpm/0UbznEfsaWMopmftsg2ee5wkjr9VDsW2Plhf3RmBDrbPNA7mxwTvbdR0GhjpWAIR04zfrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=q/XqVzA6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YSKPC4FElUpbwkgS9pekTOtQSr+FIY4IZymZn7nPurM=;
	t=1706611608; x=1707821208; b=q/XqVzA6YN6wq/kNZMQT/j3yg0s5zqsfZkSzfwVOdSZEe5t
	0tYnBB4pR4VdmJJlBgYDm6JycMxsbpOeLX38J8nnQjy34Ji5i0oL13Ifq/Smjuoydj8fdFmAEAsaN
	gQCo9TjIFN7tIoDK2CnRWDSGxokrG11HRkIPYBOrN0jJO2megW0eLPK+uV1rz3+z5MsF9cNAvISrQ
	STQ8KwCUPsS0OmW1c2IeBt5kUt/WWPc/MEpuPmEDW5lOrxM21n3meGHk50UIuEiO9uOxLaaWxrywE
	4/fV4UAuf2L/KQQ7lU2i/Ocv2KRs5hAmIJEA8wIiPyLzhFgI2umtOlgQ/j0LRHFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUldc-00000005znI-2Rtu;
	Tue, 30 Jan 2024 11:46:44 +0100
Message-ID: <52287b3162cf6632e7999216cf1ad97b2280b584.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] wifi: cfg80211: add support for link id attribute
 in NL80211_CMD_DEL_STATION
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 30 Jan 2024 11:46:43 +0100
In-Reply-To: <307eaecc-fd88-4fd8-8857-dd3910257d34@quicinc.com>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
	 <20240125125855.827619-2-quic_adisi@quicinc.com>
	 <61ad9e10e42c9f114c2a7de534690f8c0133bf58.camel@sipsolutions.net>
	 <307eaecc-fd88-4fd8-8857-dd3910257d34@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2024-01-27 at 11:14 +0530, Aditya Kumar Singh wrote:
> On 1/26/24 14:36, Johannes Berg wrote:
> > On Thu, 2024-01-25 at 18:28 +0530, Aditya Kumar Singh wrote:
> > > Currently whenever NL80211_CMD_DEL_STATION command is called without =
any
> > > MAC address, all stations present on that interface are flushed.
> >=20
> > True.
> >=20
> > > However with MLO there is a need to flush the stations from a particu=
lar
> > > link in the interface, and not from all the links associated with the=
 MLD
> > > interface.
> >=20
> > Fair enough, I can get behind that.
> >=20
> > Edit: reading the code - I think I misunderstand that ... you're
> > actually trying to remove all MLDs ("STATION") that have an active link
> > on this link?=20
>=20
> Yes correct. The station might not be MLD station. It could be a legacy=
=20
> station (non EHT) as well.

We pretty much treat that the same though as an MLD station with a
single link, with some caveats of translations, no?

> Correct, for the first bring up not required but one use case I see is -=
=20
> the hostapd interface was disabled for some reason. While going down, it=
=20
> would have cleared the stations on the kernel but what if for some=20
> reason kernel did not clear the station entries and there are some stale=
=20
> entries present? So at next bring up (during enable) it would send the=
=20
> command without any MAC address to flush all stale entries (probably as=
=20
> a safety so that kernel and hostapd would now be on par).

I don't think this really makes much sense. The kernel can't keep track
of those stations properly if they're there, and anyway that'd be a
(pretty massive!) kernel bug?

Anyway, I think there probably _is_ justification for this (link
removal?), I'm just not sure this bringup flow really is a good
justification.

> > > Hence, add an option to pass link ID as well in the command so that i=
f link
> > > ID is passed, station using that passed link ID alone would be delete=
d
> > > and others will not be removed.
> >=20
> > So first: Do you want some feature flag that indicates this? Or will we
> > just eat the cost of kicking out everyone (without even sending deauth
> > though, I think?) when running on older kernels?
> >=20
>=20
> If what I said above was the actual intention, then kicking out everyone=
=20
> without even sending deauth makes sense? Yes? If yes then we don't need=
=20
> a feature flag.

Does it though? Even if you're talking about init, you could have init
of one link much delayed for CSA, for example, with stations already
connected on the other(s).

> > Secondly: why is this part of NL80211_CMD_DEL_STATION? I'm not convince=
d
> > that makes sense. I actually kind of get why you're doing that - it's
> > easier to retrofit into the existing hostapd, but I don't necessarily
> > think that the hostap design (problems?) should influence this too much=
.
> >=20
> > IOW, it would feel much more appropriate to have this as part of
> > NL80211_CMD_REMOVE_LINK_STA? After all, when going to MLD then "STATION=
"
> > now represents a "peer MLD", and "LINK_STA" now represents an affiliate=
d
> > STA. And flushing all affiliated STAs is what you want.
> >=20
> > So I think it should be NL80211_CMD_REMOVE_LINK_STA without a
> > NL80211_ATTR_MLD_ADDR.
> >=20
>=20
> At least as per the current way of NL80211_CMD_REMOVE_LINK_STA=20
> implementation, it did not made any sense to delete all link STAs if=20
> MLD_ADDR is not passed. So probably the command should be called as many=
=20
> times as there are active links in the STA?

Not sure I understand this, we're doing a kind of flush here, so you
could (conceptually) say "flush all link STAs on link 5", no? And
obviously stations that have no link left after this need to be removed
completely.

Note this raises an interesting point in mac80211, in that there's one
link ('deflink', the link the STA used to assoc) that cannot be removed
from an MLD station even.

But again this comes down to what you actually _want_, I think, so I'll
keep reading for now.

> Still I feel that NL80211_CMD_DEL_STATION is the proper place to put=20
> this? Without the current change also, it used to flush all STAs=20
> whenever MAC address is not passed. With MLO, now we need to flush STAs=
=20
> only if it is using the given link ID. So that link STAs from other=20
> affiliated links of AP would not be flushed.


Right so this is coming to the point where I wasn't sure earlier what
you actually meant, and I'm still not entirely positive I've understood
it. Let me read on ...

> Scenario I'm targeting is this -
>=20
> Pre-MLO
> ----------------------------
>=20
> sdata -> 2 GHz AP interface
> sta_lists ->
> 	1. sta -> connected 2 GHz AP sdata
> 	2. sta -> connected 2 GHz AP sdata
>=20
> After NL80211_CMD_DEL_STATION is given without any MAC address,
>=20
> sta_lists ->
> 	No entry(ies)

Right.

> With MLO
> -----------------------------
> sdata ->
> 	link_data -> 2 GHz AP link (link ID 0)
> 	link_data -> 5 GHz AP link (link ID 1)
> 	link_data -> 6 GHz AP link (link ID 2)
> sta_lists ->
> 	1. sta -> connected AP MLD sdata
> 		link_sta 0 -> connected to 2 GHz link
> 	2. sta -> connected AP MLD sdata
> 		link_sta 1 -> connected to 5 GHz link
> 	3. sta -> connected AP MLD sdata
> 		link_sta 2 -> connected to 6 GHz link
> 	4. sta -> connected AP MLD sdata
> 		link_sta 0 -> connected to 2 GHz link
> 		link_sta 1 -> connected to 5 GHz link
> 		link_sta 2 -> connected to 6 GHz link
>=20
> Assume 5 GHz goes down and it gives NL80211_CMD_DEL_STATION without any=
=20
> MAC address,
>=20
> sta_lists ->
> 	No entry(ies)
>=20
> This is not desirable since 5 GHz link went down, why 2/6 GHz STA also=
=20
> got flushed.
>=20
> Hence with the proposed change, only sta #2 and #4 would be flushed=20
> since only these two are using passed link ID (which would be 1).
> Hence after the command,
>=20
> sta_lists ->
> 	1. sta -> connected AP MLD sdata
> 		link_sta 0 -> connected to 2 GHz link
> 	3. sta -> connected AP MLD sdata
> 		link_sta 2 -> connected to 6 GHz link

Right, OK.

So you _are_ indeed wanting to remove all MLDs *entirely*, if they use a
specific link.

Agree that in this case, NL80211_CMD_DEL_STATION with link ID makes
sense as implemented, but probably need to clarify a little bit overall
that this is the operation, seeing how I was confused about whether you
want to remove only the link STAs on on those links, or the entire MLD
stations.

(and yeah, our terminology here is confusing and doesn't help either,
but that's because we didn't rename STATION to MLD or something
everywhere)

> Now, if ML re-config support is present, then hostapd (or the user space=
=20
> controller for that matters), could first issue=20
> NL80211_CMD_REMOVE_LINK_STA for the MLD STA (#4) and remove link sta=20
> with ID 1 from it. So that when NL80211_CMD_DEL_STATION comes, it would=
=20
> not remove the 2/6 GHz link STA as well from the MLD STA and hence flush=
=20
> the whole entry.

Right, OK!
But see above - that NL80211_CMD_REMOVE_LINK_STA as described here may
or may not be possible today in mac80211.

> The above change is not there yet in hostapd, so for the time being,=20
> whole MLD STA would be flushed.

OK.

> > > @@ -16827,6 +16840,9 @@ static const struct genl_small_ops nl80211_sm=
all_ops[] =3D {
> > >   		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP=
,
> > >   		.doit =3D nl80211_del_station,
> > >   		.flags =3D GENL_UNS_ADMIN_PERM,
> > > +		/* cannot use NL80211_FLAG_MLO_VALID_LINK_ID, depends on
> > > +		 * MAC address
> > > +		 */
> > >   		.internal_flags =3D IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
> >=20
> > Hmm? How does NL80211_FLAG_MLO_VALID_LINK_ID depend on the MAC address?=
!
> > It ... doesn't?
> >=20
> I mean intention was that if MAC addresses is passed then no need of=20
> link ID. That is why did not add the valid link flag since it would=20
> expect the link ID even when MAC address is passed.
>=20

Ah, OK, that makes sense.

Maybe rephrase that comment? I was also thinking of just refactoring the
logic into a helper function, but that may be difficult, not sure. It
just looked similar.

johannes

