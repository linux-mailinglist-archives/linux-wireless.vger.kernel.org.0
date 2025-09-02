Return-Path: <linux-wireless+bounces-26932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F973B3FD08
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 12:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC93E174AB0
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2333D242938;
	Tue,  2 Sep 2025 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IdKKBKIr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69143145355
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810351; cv=none; b=LO7n6XLj6pMqrgfopuaAF3eIdNcB3Z/62l2zuZzgRm0EjtI7nlQQtNV9dbRVdjS2Ic6/tsKzkxQZQ1VaVfGeEe45pC14EJ5QFJqkNzlMrH29uMDeR0bOwc0j/gMvpFggA6Tr8XxtJxk9YEILzEcfUTFLlhhwtpiBE8CV1LHKAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810351; c=relaxed/simple;
	bh=UnJSZ1XOCLCbxlFyDLXFIo+AWUff7QGm7jSCIOLTsmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ipZKlPUGNMPfpRxAg9HJgf9Zg6Ne37lZlCTNw9ZiO1bDRE3ndlVty1kAge4cTxzzj0+yMKVQ9QRB9+3Dh2fDSncEAsvKg3ioF/PsThpjMcGAFHCOnkACilk1w3lQJjRhGpX7TtusMlfsXqkc1KjsTSj/xd9pCKE3a8wk9RvjIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IdKKBKIr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dLBg/woSqnDot1GAz414ERR54D/CsmWtU8nzBDSq9w4=;
	t=1756810349; x=1758019949; b=IdKKBKIr6Nxn22nPjvfTYYqH2WXqjyNMaEH/xnR8eZAcxZ2
	UZloTgdFZgMHN+J3Xsu/8JLNcUkUINHWK3Smmnd6ju+Q0ozAOCp4pHyKZ3fxKxEOLLHtiiaZeChT/
	5hDJ5neH/uXsqtKytwu+N4QU90nwylYMfXXO8PvbP751yqpJmSuFVlQGe0iIxNuQB/wWpE4tPJ0iD
	JOsPxjcv6UN4qNCUnk5qozogyWD+D3676WvQrB3/5BuTLmr2l1OoKMQ8r4MBPQ83iR/ffs8YAHkZs
	F0N4+gk+lHDxV4Tbm+Kjjlwi+Dbg7dNErx8VUceqFnjHJyf26HuhJk2SfXJMpizA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1utOck-00000008gzG-297g;
	Tue, 02 Sep 2025 12:52:26 +0200
Message-ID: <9363e3a700565a34145be7268deb0a8623f659ba.camel@sipsolutions.net>
Subject: Re: [PROPOSAL RFC] S1G Primary Channel Implementation Proposal
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 02 Sep 2025 12:52:24 +0200
In-Reply-To: <czhftz5pdqx4edw4xr73svcr5cxfzzwa2r547p52tmsgywsb34@k5ooo5iw5mcu> (sfid-20250827_080037_104246_E84172B0)
References: 
	<xu4ftmpdwwpokw6exaprrv6wleptq7ggleiluiu6x2dzqbqfhv@6s4m3okiohzw>
	 <75245df8edd5bbaa8f9cdfd12bab37720473d93d.camel@sipsolutions.net>
	 <czhftz5pdqx4edw4xr73svcr5cxfzzwa2r547p52tmsgywsb34@k5ooo5iw5mcu>
	 (sfid-20250827_080037_104246_E84172B0)
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

On Wed, 2025-08-27 at 16:00 +1000, Lachlan Hodges wrote:
> > How is the primary channel in S1G different from the primary channel in
> > 2.4/5/6 GHz bands? The widths are multiples of 20 MHz rather than
> > multiples of 1 MHz, but it seems pretty similar otherwise?
>=20
> Ok so reading below, I think the only difference is that the S1G primary
> can be 1MHz or 2MHz. That shouldn't matter though, see below

So reading all of this a few times, I think I've come to the conclusion
that we might be operating with different assumptions on what actually
exists as a "struct ieee80211_channel". Even in HT/VHT/... it can be
confusing.

For example in 5 GHz only channels 36 (5180 MHz), 40 (5200 MHz), 44, 48
etc. are actually present as "struct ieee80211_channel" [1]. Still,
people will tell you that operating in 40 MHz is "channel 38" for
example. This doesn't even exist as such, it's captured as a chandef
that has
 - primary channel pointing to the channel 36 struct ieee80211_chandef
 - width 40 MHz
 - center frequency 1 of 5190 MHz
 (other fields are unused)

Yes, the center frequency is actually where channel number 38 would be
(5190 MHz), but that channel number 38 does _not_ exist as a struct
ieee80211_channel.

[1] In most drivers/devices; there are some like Broadcom that also have
channel 38, 42, etc. but that's for use as 10 MHz channels, not relevant
for this discussion where we're considering how 20 MHz channels are
combined into wider channels.


With that out of the way ...

> > So I'm not sure statically disabling the channels from the driver works
> > unless you assume there's no regulatory domain involved or anything?
>=20
> Right now (as since I sent this eamil I've written the patchset) the firm=
ware
> notifies us of disabled primaries, so then driver would add the flag to t=
he
> selected channels before registering the wiphy.

Right, you mentioned that in the other email - seems fair, I'll put that
aside for this subthread which is now more about the chandef.

> > Why not do it similar to what HT/VHT/HE/EHT does, and have:
> >=20
> >  * ->chan points to the primary 1 MHz channel
> >  * ->width is 1, 2, 4 or 8 - which already exist
> >  * ->center_freq1/->freq1_offset is the center frequency of the entire
> >    channel (e.g. 924 for channel 44 8MHz, or 921.5 for channel 39 1MHz)
> >=20
> > This doesn't capture the fact that the primary channel could be 2 MHz
> > wide, either we add that as a separate channel struct (not sure?) or we
> > just add a flag or something? TBH with how this was done I always
> > assumed the primary channel was _always_ 1 MHz wide.
>=20
> So you are right, I re-read the VHT channelisation and also the chandef
> and everything is there except for the primary channel location (will get=
 to
> that shortly). Fleshing out your example:
>=20
> * ->chan points to the primary 1MHz or 2MHz channel
>=20
> S1G channels contain the width flag (IEEE80211_CHAN_1MHZ/2MHZ) so that
> can completely represent the primary channel. This channel would then
> be required to exist as a subchannel within the operating channels
> frequency range. (I assume this to be the same case for VHT / EHT etc.)

So I'm not sure this is correct the way you phrase it. The flags in
struct ieee80211_channel have IEEE80211_CHAN_{1,2,4,8,16}_MHZ, but
that's documented as saying these widths are _permitted_ on the
frequency range described by the channel.

So when you talk about "a channel", do you mean an individual 1 MHz
channel that could be combined with others in multiple ways to give
wider channels? The discussion about disabling primary on the edges
implies that yes, you're thinking of it the same way as I described
above for HT/... - it wouldn't work if your overall "channel" isn't a
composite of multiple struct ieee80211_channel "channels". OTOH, this
width thing here makes me think you'd actually want a struct
representing e.g. 40 with 2 MHz if that's the primary?

>=20
> * -> width 1/2/4/8
>=20
> This would be the operating channel width, channel 44 would be 8MHz.

Yeah, but please be more precise which of the multiple meanings of the
word "channel" you mean :)

> * ->center_freq1/->freq1_offset
>=20
> This would be the operating channel center frequency. So for example,
> channel 44 would be 924MHz.

Right.

> As mentioned, the one difference is that S1G primary channels can be 2MHz=
.
> The standard (and by extension, the S1G Operation element) uses the notio=
n of
> primary channel location. When we have a 2MHz primary channel, the AP mus=
t
> specify which 1MHz subchannel _within_ this 2MHz primary channel is used.

Wait, that's confusing. If the _primary_ channel is actually 2 MHz, why
does a 1 MHz subchannel even matter? In my definition of the words
"primary channel", it'd mean that you actually have 2 MHz like in HT you
have 20 MHz, and you cannot do anything narrower.

But that's actually a bit strange because how would 1 MHz and 2 MHz STAs
discover each other, so then what does "2 MHz primary channel" even mean
if it still has a "1 MHz primary" within that?

What if you have 1 MHz primary and then 2 MHz primary and then 8 MHz
overall chandef? Where am I confused?

> Now Im inclined to place this in the chandef, as it's a value used to
> "configure" a channel... :). Anyway, that is an implementation specific
> thing - we can clarify that during the review process.

Yeah I'm confused as to what "channel" means in what part of your
mail... here it clearly means the "overall channel", i.e. something
described by the chandef struct, but I'm not sure when and how you
actually describe something (new) by the channel struct (except the new
flag of "this cannot be primary".

johannes

