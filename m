Return-Path: <linux-wireless+bounces-26658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B04FB372AE
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 20:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABB63B5873
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F71A76B1;
	Tue, 26 Aug 2025 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ar2/j8aZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAEE2F6597
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234586; cv=none; b=XLNY5Tr1Bznq4kek5SW67HsL32nDzfnbkp9gHiH6NJMA1Y6ZDXAk5clHHKxbc7u7lwJzCeLzfYPb8wfzlYXUdJIKYtvhJ5cDSKA24H9ps3KCZzaTLhEkG4gXvugKzCoAfvlBWiroaELNdzT3jZm4nVtYtXuKL0C2a6JIgTgdUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234586; c=relaxed/simple;
	bh=FD5LbJaZre76+NqyE2z9QGSfpYc5+jSzJIvptI7v1Ao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WBQJYPdrRBpiylWAOn9DmVwX3+49MEDtuu+YRDpkXg86TQ58Rn+YLXxA2M4SGbiuEYH210/yST4FFBElD55ElQkuNF5B8ShHzq9I+2BKJiyUmQVU0Zc32363BMHiI7B0EU38GL3pxnQfZUxx2fnezm+NrUwXTWEgAxVhLBw/ntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ar2/j8aZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xxA9AXkwa7x00rKajLdGfPrqCO6VuyNdHQkTwVNJL8c=;
	t=1756234585; x=1757444185; b=ar2/j8aZx5bhEpwSt6iqS7ktVf7RD3jkCqWdAY+r1POA4IG
	nhId0SZuhe4/vBq8MAMZ1xV960jhT5BA1BxtJ4nWsiuHSzudrxlzRfiPmpmg3YQbOYfzvgat0IYeD
	9CFcd5GG0PmVgGsf94I3qyDXjRKyG0gMK834ri7otUMsfEVQkr5fgMX9rgnA87gCrKIT3LJHJ2W6Y
	yc6fbKSvsll3FGyS6MhX7iBWKsHrgQhft1V5ys7RJ9+Zbq2O3H82w/IGKlUom6e3gzY0ekLPCNuQf
	dCexUmIDvPsBFsbefwacm2xULSL0xi7vE8UoV5eITCTvIh2BnPAfGnXtVFwyVukw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqyqE-00000004427-1zmT;
	Tue, 26 Aug 2025 20:56:22 +0200
Message-ID: <75245df8edd5bbaa8f9cdfd12bab37720473d93d.camel@sipsolutions.net>
Subject: Re: [PROPOSAL RFC] S1G Primary Channel Implementation Proposal
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 26 Aug 2025 20:56:21 +0200
In-Reply-To: <xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw> (sfid-20250804_091154_355712_2B65336A)
References: 
	<xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw>
	 (sfid-20250804_091154_355712_2B65336A)
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

On Mon, 2025-08-04 at 17:11 +1000, Lachlan Hodges wrote:
> Hi Johannes, Wireless,
>=20
> One of the last remaining pieces within cfg80211/mac80211 to enable
> complete S1G functionality is primary channel support. We've identified
> a couple of potential implementation specific issues and would like
> maintainer input prior to developing the patchset as it may be
> mildly contentious.
>=20
> Background
> ----------
>=20
> The channelisation of an S1G PHY consists of two components, a center
> frequency and a primary center frequency as per IEEE80211-2024 23.3.14.
> The center frequency is equivalent to other PHY types, being the center
> operating frequency for the operating channel and the primary center
> frequency being the center frequency for the primary channel.
>=20
> When an S1G PHY changes channel, it requires both the operating channel
> and the primary channel parameters. The implementation of this will be
> briefly mentioned at the end of this email.

How is the primary channel in S1G different from the primary channel in
2.4/5/6 GHz bands? The widths are multiples of 20 MHz rather than
multiples of 1 MHz, but it seems pretty similar otherwise?


> S1G Channel Structure
> ---------------------
>=20
> S1G has a hierarchical channel structure. Below is a snippet from the
> IEEE80211-2020 Australian/US S1G band. The righthand side |*|
> represents the FCC band edge. Above the =3D=3D line are the designated
> channel numbers and on the left column their respective bandwidths.
>=20
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

Yeah ... I mean if you replace 1 MHz by 20 MHz, 2 by 40 etc. then it
looks pretty much the same as for EHT with up to 320 MHz? Except the
frequencies and channels?

> S1G Channel Selection Example
> -----------------------------
>=20
> An example channel configuration would be an operating channel of 44 and
> a primary channel of 37. The primary channel must be a 1MHz or 2MHz chann=
el

OK that's different I guess, the primary channel in HT/... would always
be 20, not 40, like here where you can have both 1 and 2?

But I'm still not sure I'd think about it so completely differently?

> and must exist as a primary subchannel within the operating channels band=
.
> Using the sample above, operating channel 44 can have a 1MHz primary of
> 37, 39, 41, 43, 45, 47, 49 or 51 and same goes for the 2MHz channels. Whe=
reas
> an operating channel of 40 may only have primary 1MHz channels of 37, 39,
> 41 and 43.

Again, very similar to HT etc., which is all captured well by the
chandef today.


> Regulatory Emission Challenges
> ------------------------------
>=20
> To control RF emissions during FCC compliance testing, hardware vendors
> disable edge-band primary channels to meet emission requirements. [1], [2=
]
> and [3] show 1MHz and 2MHz primary channels on band edges disabled. This,
> however, does not prevent the operating channel from being used. This is =
due
> to the OFDM envelope peaking near band centre, providing enough spectrum
> roll-off to satisfy emission limits.
>=20
> Using [3] as an example, primary channels 51, 50 and 49 are disabled duri=
ng
> testing, but operating channels 48 and 44 are still tested (both of which=
 contain
> the disabled primary channels). These configurations all passed FCC requi=
rements.

OK, that seems a bit annoying, but not really all that problematic.

> Proposed Solution
> -----------------
>=20
> We propose a new flag within struct ieee80211_channel_flags called
> IEEE80211_CHAN_S1G_NO_PRIMARY or something similar that tells the
> wireless subsystem that this channel cannot be used as a primary channel,
> but is not disabled. This is an important distinction as during subchanne=
l
> validation, if a single subchannel is disabled that operating channel can=
not
> be used (similar to VHT and other PHY types) but an operating channel can
> be used if an edgeband 1MHz channel has the NO_PRIMARY flag but is _not_
> disabled.
>=20
> NB: While the existing for_each_subchan macro doesn't work for S1G channe=
ls
>     given its fixed step size of 20MHz, this will be updated during
>     the implementation.
>=20
> It's also important to note that this can only apply to edgeband primary
> channels for the current regdom. This validation will be performed upon
> advertisement by the driver of the available channels for the S1G band.
> Additionally, puncturing is not supported for S1G.
>=20
> This will be an implementation detail, as this is not explicitly describe=
d
> by the standard, but rather used by vendors to ensure FCC compliance.

Hmm. So first I wanted to say that this totally makes sense to me. But
actually I'm not so sure. I mean, get the restriction and why it's
needed and all that, however, we have to consider interplay of various
factors here.

Consider the difference between AU and US in the regdb (the only
countries currently listed with S1G support):

country AU: DFS-ETSI
        (915 - 920 @ 4), (1000 mW)
        (920 - 928 @ 8), (1000 mW)

country US: DFS-FCC
        (902 - 904 @ 2), (30)
        (904 - 920 @ 16), (30)
        (920 - 928 @ 8), (30)

I'm not sure which operating class you're applying to get those channel
numbers in your figure above, so I'm going to have to handwave a bit.
But assuming such a restriction also applies on the lower band edge
(OFDM is symmetric, so it probably should) then you'd have to disable
different channels in AU and US regdomains, since one starts at 902 MHz
and the other only at 915 MHz. So for a channel that's between 915/916
MHz (which according to your figure I guess would be channel 27?) you'd
probably have to disable it in AU but not disable it in the US?

So I'm not sure statically disabling the channels from the driver works
unless you assume there's no regulatory domain involved or anything?

If I'm right about this, then perhaps it should be expressed as a
(wiphy-specific) "primary channel band edge distance"?

> Primary Channel Representation
> ------------------------------
>=20
> One potential challenge with actually implementing primary channel suppor=
t
> is how and where the primary channel is described. Initially it was thoug=
ht
> that a channel definition could contain a separate struct ieee80211_chann=
el
> like such:
>=20
> struct cfg80211_chan_def {
>         struct ieee80211_channel *chan;
>         [...]
>         struct ieee80211_channel *s1g_pri_chan;
> };

Just off-hand, that seems awkward.

> The obvious problem with this is that now a channel definition describes =
two
> channels, though you could argue that to correctly describe an S1G channe=
l
> you require both components - which in some regards makes sense to put th=
em
> both in the channel definition. It does, however, require various API cha=
nges,
> with the biggest one being cfg80211_chandef_create() to accept the new pr=
imary
> channel parameter. An alternative is to create an S1G specific chandef cr=
eation
> function which can then call the generic form.

Yeah, but not even just technically awkward.

It's also a complete deviation from how anything else works, and you'd
actually have to have different channel structs for all those
'aggregate' channels like 44, which we certainly don't do for EHT. If
this is the wrong way to think about it in EHT, why would it be the
right way to do it in S1G? Even in EHT the whole channel is "44" (to
stay in your numbering scheme), but the full channel is expressed as the
overall width/center_freq1, and the control/primary channel is the
pointer to the channel struct, and channel structs only exist for the 20
MHz channels.

> Additionally, we can reuse cfg80211_chandef_valid() to perform validation=
 as
> both the operating channel and primary channel exist within the same
> channel definition. By extension, many of the function that operate on a
> chandef have access to both the primary channel and operating channel.
> Definitely something to consider.
>=20
> The second option is to treat them as two separate channel definitions. T=
his
> is probably more "correct" as after all a primary channel is a separate c=
hannel.
> While this approach doesn't require many major API changes like the previ=
ous
> method, it still has some negatives. Firstly, the need to carry a separat=
e
> channel definition in various places. Taking struct ieee80211_chanctx_con=
f as
> an example:
>=20
> struct ieee80211_chanctx_conf {
>         struct cfg80211_chan_def def;
>         [...]
>         struct cfg80211_chan_def s1g_pri_def;
> };
>=20
> When building this new channel definition, we probably don't want to be u=
sing
> _nl80211_parse_chandef() as it relies on the NL80211_ATTR_WIPHY_FREQ to f=
ind
> the channel, where the primary channel center frequency will rely on a se=
parate
> attribute. Now we could, of course, add in another branch to handle this =
case,
> but the function seems fairly overloaded as is and would be good to keep =
the
> S1G specific case separate.

I'm not really sure this is all that much better?

Why not do it similar to what HT/VHT/HE/EHT does, and have:

 * ->chan points to the primary 1 MHz channel
 * ->width is 1, 2, 4 or 8 - which already exist
 * ->center_freq1/->freq1_offset is the center frequency of the entire
   channel (e.g. 924 for channel 44 8MHz, or 921.5 for channel 39 1MHz)

This doesn't capture the fact that the primary channel could be 2 MHz
wide, either we add that as a separate channel struct (not sure?) or we
just add a flag or something? TBH with how this was done I always
assumed the primary channel was _always_ 1 MHz wide.

johannes

