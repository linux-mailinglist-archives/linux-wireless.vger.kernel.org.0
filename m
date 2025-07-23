Return-Path: <linux-wireless+bounces-25931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B2BB0EFE8
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 12:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DDE168B46
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 10:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CFD282F5;
	Wed, 23 Jul 2025 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m60CFsup"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A40276036
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266795; cv=none; b=E3qg0yqjk4cYYXgzVTyOnKFE3F7iIZQ4buOYqllq1/5iNc0Etac2GvRsCPDALCHgC+RrjnnhutHzEhmhFkXXS0M7EQDRbmesOH8vvLutrR/tDNAelmgjJlnKW9lik31O4hEEm09N27hCMKelIfLgPABE5Duu7mK2pa1EAoaKJKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266795; c=relaxed/simple;
	bh=fBJvd1rWqbE6od8X5L3tNBYqoVqOIDa//jOAAwrPY+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FEVIq0K3HpcWWdrdEAoQaKir7zDQzdJwdCuUUOKWH0z4mg526mRnWMxqPNy5jsFJQw3LcRPHASAUCzhB+Am7azvCWzsfcmUayp5qz6exJx8WyW5f60lpKVxwkl5NlCmf8dYQnvFgzAEjstTn5+k76pZee6aY/1ti73n1cxlCHP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m60CFsup; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gBa3K+sc+FwHwIkPMuRBeiCuVDJecjqms6fuxGMFbLc=;
	t=1753266793; x=1754476393; b=m60CFsup83UdjJtHYROU4P4hhbzhF/0omuWwKTaxgTiqqzF
	e27lx6LSzvqWiSG182T0dCo6yU2JGBlLxK77w1MuGUgNYTp9vKuJMxScj0iRXOZpdczw+wN7JFJAm
	4AzKDA6xK7+dnEm3aD6ZDej2soW7snQDdWOYz/y+BqbRj0q/jEXc7n87LZgQYdycAP+Bwo0LfVB4B
	ooTTNV9hc+3jhaVgX/uT6VfVgKl0+/6AlsYVmMJGdJdi2UGvtH8nogsK7Jrdu58F1j3wUsUU0F//1
	Z316S6je7XkjYekRE+j75qCYhFvGYSGfR03iHAlIDqwxgtY631CcMc4Yu/b1OJMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueWma-00000003iAq-29aA;
	Wed, 23 Jul 2025 12:33:08 +0200
Message-ID: <08fee54dd5afc5c8b4966188eb3016713a3d8c8a.camel@sipsolutions.net>
Subject: Re: [DESIGN RFC] Critical Update handling in the kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, Ping-Ke Shih
	 <pkshih@realtek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
	 <ryder.lee@mediatek.com>
Date: Wed, 23 Jul 2025 12:33:07 +0200
In-Reply-To: <4a94fa66-8140-4cc8-996c-0ed097b4004a@oss.qualcomm.com>
References: <20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com>
	 <1a77ca6a35ad03f839b7c997de3977b521d88edc.camel@sipsolutions.net>
	 <4a94fa66-8140-4cc8-996c-0ed097b4004a@oss.qualcomm.com>
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

On Wed, 2025-07-23 at 10:04 +0530, Aditya Kumar Singh wrote:
> > FWIW we also have some client side code for it already. It's probably
> > broken ;-)
>=20
> Yes, I=E2=80=99ve seen that. I=E2=80=99m not entirely sure if it=E2=80=99=
s broken, but it does=20
> seem related to CSA parsing from the link=E2=80=94there is code handling =
that.=20
> If anything turns out to be broken, we can fix it.

We just never tested it well, that's why I said that. Sure, if it's
broken we'll fix it.

> > > Assumptions:
> > > ------------
> > > The critical update procedure is highly timing-sensitive.
> >=20
> > There are two aspects here that I feel maybe you're conflating a bit. O=
n
> > the one hand, yes, some of it needs to have the precise information for
> > the counters. OTOH, some of it is really not _that_ timing critical,
> > e.g. whether or not you actually get the information live at exactly th=
e
> > right time. Though of course a frame that's transmitted after a beacon
> > that advertised CSA should not suddenly _not_ advertise it even cross-
> > link.
>=20
> Absolutely! We acknowledge that achieving the ideal case may not be=20
> possible. Keeping the logic in the kernel brings us closer to the=20
> expected behavior, whereas shifting it to hostapd would likely result in=
=20
> a much larger deviation.

Fully in hostapd I would agree, but not sure it should be fully in the
kernel as you propose either? We have some middle ground for CSA today
with just the counter updates, rather than creating the elements and all
that. Not sure we couldn't/shouldn't replicate that?

> > Wouldn't it be far simpler to have hostapd indicate the critical update=
,
> > and even the BPCC value? It also has to include BPCC in RNR and other
> > fields, do we really want to _parse_ all of that and update all those
> > values?! Seems iffy at best.
>=20
> The challenge is that if hostapd takes on this task, it would need to=20
> send updates for all partner links. Theoretically, this could result in=
=20
> up to 15 beacon NLs being transmitted. Processing these NLs and updating=
=20
> the beacons would already be time-consuming.

Is it though? I mean, where do you see the bottleneck? Locking wise it's
just the wiphy lock that shouldn't be contended, netlink isn't the most
inefficient API ... sure there are roundtrips involved, but this seems a
bit "handwavy" to me.

We could also always have new per-link attributes for the beacon
template updates for other links so it doesn't require full commands but
just updates the beacon tail (probably only that?) of other links in the
same operation?

> On top of that, managing=20
> the additional offsets required to update the counters adds another=20
> layer of complexity.
>=20
> OTOH, the proposed design just takes 1 NL update and rest it does=20
> automatically what is needed which will be less time consuming than=20
> multiple NL commands flow.

I still don't buy the "time consuming" thing, but I agree that managing
the counter locations would be more difficult. OTOH, that's a list of
counters per link, so it's not _that_ much complexity?

I really don't like the parsing in kernel for two reasons:

 1) it's a lot of complexity that would never exist at all when hostapd
    gives the data because it's building it, it doesn't need to parse

 2) less importantly, I also think it ossifies things since the kernel
    would need updates for even minor changes in the layout or elements
    (this of course already being true for FW based solutions)

> > >      2.2 Parse the MBSSID profile element.
> > >          2.2.1 For each non-Tx profile:
> > >              2.2.1.1 Extract the BSSID
> > >              2.2.1.2 Retrieve the corresponding link sdata from BSSID
> > >              2.2.1.3 If the critical update flag is set in link objec=
t, set
> > >                      the CU (Critical Update) bit in the capability e=
lement.
> > >              2.2.1.4 Set non_tx_update =3D true.
> > >      2.3 Parse the multi-link element.
> > >          2.3.1 For the self link (already known), fetch the latest BP=
CC
> > >                value.
> > >          2.3.2 Update the frame with this BPCC value.
> > >      2.4 Update the capability element in the SKB:
> > >          2.4.1 If the critical update flag is set, set the CU bit.
> > >          2.4.2 If non_tx_update =3D=3D true, also set the non-Tx CU b=
it.
> >=20
> > How much of that can we let hostapd do?
>=20
> hostapd forms beacon so it can do all of this. The only bottleneck is=20
> communicating all link's beacon update sequentially via NL. And if=20
> another update happens in the meantime - for example link A started CSA=
=20
> and then link B also started CSA, these will pile up the NL socket queue=
=20
> with beacon updates.

I do wonder if this is a practical concern? And if you have seen this in
practice then where does the bottleneck come from?

But it can also be side-stepped by batching the operations and not doing
a full update like I wrote above.

So I'm not sure from a design perspective for mac80211 we should let it
be constrained by this. That doesn't mean there aren't other reasons for
the design to go either way, but we can work around this one (if it even
is an issue.)

> > > This mechanism sufficiently handles critical updates due to modificat=
ions
> > > of existing elements (elements related to the critical update which a=
re
> > > already present in the beacon and just one or more field is/are chang=
ing
> > > its value). However, in the case of new element inclusion (elements r=
elated
> > > to the critical update which are not alread present in the beacon, bu=
t is
> > > getting added from next beacon), additional handling is required.
> > > Specifically, the newly included elements related to the critical upd=
ate
> > > must be added to the per-STA profile within the Basic Multi-Link Elem=
ent
> > > (BMLE) [3].

[snip timing explanation]

> You're right, but that's not quite what the original text is trying to=
=20
> convey.

OK, sorry, I misunderstood then.

> There are generally two types of critical updates:
>    1. Adding a new element, such as CSA or CCA.
>    2. Modifying an existing element, like VHT/HE/EHT Operation IE, TWT, e=
tc.
>=20
> In the second case, forming the beacon is relatively=20
> straightforward=E2=80=94only the BPCC and the critical update flag need t=
o be=20
> set. However, in the first case, it's more complex. You need to insert=
=20
> the new elements (e.g., CSA IE) into the per-STA profile of the affected=
=20
> link within the reporting link, as shown in the earlier diagram.

Right, of course.

> So to handle this case (additional of new element), the below steps are=
=20
> additionally required on top of what was already explained above.
>=20
> Does this make sense now?

Maybe more? I really wasn't reading it well before, I thought it was
more about when the new elements were added, rather than the fact _that_
they need to be added.

I guess to me that was really almost the same, the beacon changes.

> > That kind of also seems like hostapd could just update the beacons?
>=20
> Yes it can. Only thing is multiple NL beacon updates.

OK so if you're really so worried about that, and that's the main thing,
we can add the per-link updates into a nested element in the switching-
link's nl80211 message :)

>=20
> > > Update BPCC back to NL:
> > > -----------------------
> > > After the kernel increments the BPCC value, it can emit a netlink eve=
nt
> > > containing the updated BPCC value. This allows hostapd to receive the
> > > latest BPCC and include it in probe/association response frames, as
> > > required by the specification.
> > >=20
> > > This coordination ensures that all - beacon, probe response, and
> > > association response frames reflect consistent BPCC values, maintaini=
ng
> > > compliance with spec-defined behavior for multi-link and critical upd=
ate
> > > handling.
> >=20
> > Yeah not liking this too much I guess... Why can't hostapd maintain
> > BPCC?
>=20
> It can only when everything is fully handled by hostapd. Otherwise=20
> kernel should be owner of having the latest value. It can report the=20
> latest value to hostap upon any change.

When is it not fully handled by hostapd though? It always decides to do
updates, no? Are you thinking there are cases where the driver
(firmware?) unilaterally changes some things (say the puncturing bitmap)
and never handshakes that with hostapd, just starts overwriting the
beacons? Maybe we have a broader architecture discussion to be had here.


> > > Complexities:
> > > -------------
> > > When adding elements in per STA profile, the element length might exc=
eed
> > > hence fragmentation needs to be handled properly.
> >=20
> > We have fragmentation but all this parsing means also we need
> > _defragmentation_ first, which is awkward?
>=20
> I think de-fragmentation is already supported ? If not, we will have to=
=20
> add it to support it.

It is, generally, but it's completely separate in terms of memory
handling etc. so it's not that simple.

> > > memcmp vs hashing
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > In the section where memcmp() is used to detect changes in beacon ele=
ments
> > > (to determine if a critical update is needed), this logic could
> > > alternatively be handled at the hostapd level.
> >=20
> > Yeah sounds better to me :P
>=20
> Okay so only the link which is undergoing a change, hostapd will signal=
=20
> to kernel about critical update? Rest kernel will handled parsing and=20
> updating the partner links as per the need?

I still don't like the parsing though. Like I said above, that's a lot
of complexity that simply doesn't even exist when hostapd controls all
the updates.


I really would have envisioned this much more along the lines of having
hostapd start the channel switch (WLOG on link 1 out of links 1 and 2)
with an nl80211 message that has:

 - post-switch beacon for link 1
 - during-switch beacon for link 1
   - CSA counter offsets for CSA, eCSA, etc. elements
 - post-switch beacon for link 2 (?)
 - during-switch beacon for link 2
   - CSA counter offsets for link 1's CSA counter
     (for all the per-STA profile link 1 elements)

isn't that pretty much it? All the BPCC is well-contained within that
and maintained by hostapd.

I'll agree that this limits to only doing a single channel switch at a
time across the whole MLD, but maybe that's not the most problematic
thing?


OK I guess I'll have to think about this more ...

johannes

