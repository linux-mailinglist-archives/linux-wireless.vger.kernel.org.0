Return-Path: <linux-wireless+bounces-25862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 113E4B0DC0D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C97189596F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 13:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAA328C039;
	Tue, 22 Jul 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ELEisUBA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D23F2B9A5
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192524; cv=none; b=ukkOz0FK75SRwgLns7iwvWPOAkNZNIaOlicv/g4HywC0/Sjq5sHNS4zz3UQgBxtCZU80LJXUBcoSn8xlakFc6h74czlcF1eeiDOpRq8I5RO6/d13MFdrsM9IisbIZtwQn6x9n2boWAPpyCXX3qZ+lj0/keq1mJhqg3dOkyoDnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192524; c=relaxed/simple;
	bh=7WAifMtPIdCthEICIIFD2Z3D9w/BKsOiSHv9eL5wK3I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cuHmhXMR1dmoTo61VsIvIWFoQNld1ZTCqOYKipuXr/dfcEg0vLvwa93vwRW282gbo2ATR7UC1ayPw7U/vqAV6cVs8d2Pgm09KJSwt/06RSUvnm9nRcfWAK6LtpMXAiibUCh/wXlyoJHg4o8390NreW4sa/TdCX9GEDz/ySrczwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ELEisUBA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v6vG7ATQ29fMXm305NQvha/utHSVXGFOBtUckz7m2NI=;
	t=1753192522; x=1754402122; b=ELEisUBAK1bMWbO1qPSP+QeidXfAKCO6TOMh6EXCy08XYio
	Xv80p2ZPd7AusxM3ug8+CNBzGZA0FVhGj7q3EPC/KAfcFUOYy3ustvP8n3qNgw807bR2IzKo5cZ6s
	gTIup1zdJvRt9UFlv3hkZWCXNCrBObUKXH5uRjCEL22bV9QEpP9qdlzM8jqd6/iAk/r4U7aXeKxIJ
	XaMcjzgQYA2pOO1PQqfjQASkpmYfslxA73Hi0HUxHSc85LrZlIDznpIhS//xl9to2q/H2ccnhhUsT
	er+sDY6tOJ+qUv7cxUkviw93BVPJPajMSJ+1qwJrITyuNYKcOGxj2sGAOE0JpMDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueDSh-00000002CFu-31dE;
	Tue, 22 Jul 2025 15:55:19 +0200
Message-ID: <98abd0c936a6169a106682da9359c01708cf4ee9.camel@sipsolutions.net>
Subject: Re: [wireless-next 2/2] wifi: mac80211: support parsing S1G TIM PVB
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 22 Jul 2025 15:55:19 +0200
In-Reply-To: <ksb6rptacpnyxbcep332q247agx2u62h6o3j4oqfestaal2b7x@el6snwrs4kx5> (sfid-20250722_143050_589582_7CE82ED3)
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
	 <20250722071642.875875-3-lachlan.hodges@morsemicro.com>
	 <e60156bc1097385bceb624bac6bf55906947e6a9.camel@sipsolutions.net>
	 <ksb6rptacpnyxbcep332q247agx2u62h6o3j4oqfestaal2b7x@el6snwrs4kx5>
	 (sfid-20250722_143050_589582_7CE82ED3)
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

Hi Lachlan,

First: I missed the whole page slicing with its extra element and the
capability when I read through it earlier. But then of course we can
simply decide not to implement that on either side, i.e. client doesn't
support it, and AP just doesn't take advantage of it (and thus is
limited to fewer STAs even if some of them implement page slicing.)

(So we have dot11PageSlicingImplemented =3D false and
dot11PageSlicingActivated =3D false as well.)


> > Which ... seems questionable? At least in terms of message it's not
> > actually _invalid_ if it's out of this range, in theory S1G allows up t=
o
> > 8191.
>=20
> Yes, from a client side it is. See comments below.

Maybe I'm confused, but what do you mean by invalid from the client
side"? I've been looking now and didn't find any restrictions on the AID
for STAs that e.g. don't implement page slicing, though of course an AP
might want to e.g. reserve lower AIDs for them and always use higher
AIDs for STAs with page slicing even if lower AIDs are free.


> > Also the parsing for S1G only parses a subset of the valid formats,
> > notably the format that mac80211 can generate. That seems questionable,
> > unless you expect there never to be another implementation (or the
> > mac80211 one to never be extended) and you can basically make up your
> > own standard?
> >=20
> > And even if you _do_ get an AID that's <1600 there's still no guarantee
> > that the encoding will be in the bitmap format, if only two stations
> > have traffic the AP might well decide to use the "Single AID" mode?
> >=20
> > So I'm overall a bit confused how all this is meant to work - even if
> > only partially - because AID<1600 is no guarantee that you can parse th=
e
> > bitmap, so turning off powersave only for AID>=3D1600 will not really b=
e
> > sufficient?
>=20
> This is something we discussed internally, and in retrospect mac80211
> should be able to parse all types, even though it may only encode a
> single type. So actually my reasoning for this is not very good as it
> was essentially "nobody uses the other encoding modes" but in the future
> who knows if that will remain true...=20

Yeah OK, that's fair, I'm really not going to push you too hard push
into "must implement the spec faithfully" territory, and you know better
than me what might be deployed or not matter, and lifetime of systems
being built now possibly factors into it etc.

Mostly I'm asking because I didn't really understand what it was trying
to do, so even clarifying that only part of it is implemented might be
reasonable.

> After verifying with the standard and based on your feedback here is
> what I propose:
>=20
> For a first implementation, we still won't support page slicing - but
> this is fine as it is an advertised capability.

Right.

> A new bitmap
> should be added for S1G (as mentioned, probably a union of some sort
> with the existing bitmap) that allows us to use the _actual_ S1G AID
> count, this ensures correct interoperability into the future and is
> safe due to page slicing being a discrete capabilitity.=20

OK I don't even follow here ... I feel confused between the AP side and
non-AP STA side now.

If you talk about a union, do you literally mean in a struct or
something? I'm not sure that really matters for either side? The AP side
has the ps->tim bitmap, but that could even remain as is, even if it
limits the # of STAs to 2008 right now. That's not a big deal, it just
limits the AIDs to that, but that's an implementation choice. It just
won't be able to have more STAs connected, but that's OK?

(In principle, we don't even really _need_ the ps->tim bitmap as a
bitmap, we could iterate the stations instead or something, but that's
more expensive and so the ps->tim bitmap is an optimisation, at least I
see it that way.)

Obviously the AP side then for S1G can't just put the partial virtual
bitmap from the ps->tim bitmap into the frame, but that's ultimately
just a question of bit twiddling while building the frame too. So not
sure where a union is needed for the AP side :)


For the client side, similarly, all it has to do is be able to walk
through the element (elements, if later implementing page slicing), and
be able to identify whether or not its own bit is set, so it never
really needs a holistic view of the bitmap.

> So as per figure 9-214, we can still use a page slice number of 31 which
> states that the entire page indicated by the page index is encoded in
> the PVB, but given we now have a correctly sized AID bitmap we would
> correctly determine the page index. On the AP side, we would encode
> using block bitmap but correctly indicate the page index. On the STA
> side, we'd properly decode the PVB with the ability to decode all possibl=
e
> formats. So this would consist of block bitmap, single AID, OLB and ADE
> alongside their equivalent inverts.

Yeah, that seems right.

(And kunit tests for this parsing would probably be a good idea :) )

> One concern I have is that without page slicing, we are limited to a TIM
> of size 255. A single page represents 2048 AIDs (page index =3D 2 bits),
> using block bitmap encoding we can overflow given worst case scenario.
> Now the easy answer is to probably encode until we hit the maximum
> length, allow STAs to clear their bit after the beacon and repeat.
> Though maybe this isn't the nicest? Not sure. Obviously this is an
> extreme case and would (hopefully) never happen in the real wordl but
> still needs to be considered. Internally, we default to block bitmap
> encoding and this isn't modified dynamically, same goes for most
> (if not all) vendor implementations - but as mentioned the client needs
> the ability to decode these other formats.

If I'm reading the spec correctly, then the worst case for only encoding
with block bitmaps would be having a large number of scattered AIDs
indicate presence, which would require

 - DTIM count [1 octet]
 - DTIM period [1 octet]
 - Bitmap Control [1 octet]
    - B0 (depends on traffic)
    - B1-B5: 31 (special page slice)
    - B6-B7: 0b00 (page index 0)
 - followed by a number B of blocks, numbered b=3D0..B-1, each:
    - Block Control [1 octet]
       - encoding mode: block bitmap
       - inverse: 0
       - block offset: b * 64
    - Block Bitmap: 0xFF [1 octet, assuming worst case]
    - subblocks [8 octets]

so out of 255 octets, 3 are overhead, leaving 252 =3D 25*10+2 for up to 25
blocks, for up to 64*25=3D1600 AIDs? I think? Which matches your 1600, so
whew, maybe I did this right ;-)

From that I'd argue the AP side should limit itself to AIDs 1..1599, I
guess? Or actually maybe 64..1663 and use the block offset 1 higher, but
probably not worth the added work just for 1 more AID.

Once you get to/above 1600 you have a trade-off to make, you cannot
indicate the absolute worst case without paging any more. You could hope
that STAs will retrieve their data and then you get free blocks, some
Block Bitmaps won't need to be 0xFF, and then you have more space, even
without resorting to other encodings.

Overall it's also an interesting optimisation problem how to best encode
this ... if you have clustered bits then a block bitmap is better, if
there are sparse bits then Single AID could be better. I can't easily
discern the cases right now where OLB or ADE would be better.

But I think for an initial implementation you could just leave that
aside, limit AIDs to <1600, implement only block encoding and accept
that it's just not optimal in many cases, but at least you won't have to
worry about not being able to include some data?

johannes

