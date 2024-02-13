Return-Path: <linux-wireless+bounces-3515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86892852B65
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 09:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352962839B2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C5E24B33;
	Tue, 13 Feb 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xUUPJfqW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC5A249F0
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813743; cv=none; b=dupEjHpMm4Tb1v71Ov1A0SHCoTZb607WdPo9CjLrr5mD3e47in6zyFOj005AeT7l3IbEn+Z+TYubbqfvmOLB6wbteNxLWSkUr7xf9iz17lKwpIf4ATjYIz6P7q4EQu0TDViPBMslOluRe1M3Vicg3Wn9VCV/Tb64dCSoinnD53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813743; c=relaxed/simple;
	bh=+QpUo3BAEe9lajUYyJQbfFKgng9PKDYD+tyvbSpMe/U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pQ5fr2PrWftidW+mcJt4A5JCjfLjs3Altia7GOmge5bpdUAWNKu41GTKuGaq8Sl9Zw6d9FwM7sS22p/hFflpwBCTsvqo9kXMyfL/l3BTIBFl9qsmyEM2S/ptb+rKPW0BoLGVPgJrg6iH9nRl8nvpgwdgmcJCszhmfKOJmF6NUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xUUPJfqW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=W9WJxeF3qaH/6RN/XZcezKzh9K9C0AM519biFudJ0PU=;
	t=1707813741; x=1709023341; b=xUUPJfqW2mTNLe6Rv2h3kUBQSeZFa/jussAhZezfBN7ysUw
	eFYh0v+g/ct+/enFOd3Zu9cZBFo4KlBSpjNLzK3cPh6s52oCx0HFgkLJaecWe2IRdFkh8/glLfcLj
	+Ih1zUUwKN4++/UFxER0jdSAn/nh0S2ndodq1tdaSKOIzV3WvU0SYMhBPi5u1nWTAgKmp9Ttb9ytl
	+oWnJPCLPuB28wxDwAe8giL7wmpngEdF1xduZZgVVdXMYJiugg9r7VsWytekRVhrMnQZwiuvyPrxf
	QLvO+DmGqXJaf8X/nf9fr19pZVuVhPxX4hFGQq2TQEYUL1Zb+3dotWT27Y8THEoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZoMo-00000007YA6-02YZ;
	Tue, 13 Feb 2024 09:42:14 +0100
Message-ID: <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson
 <quic_jjohnson@quicinc.com>,  Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ping-Ke Shih <pkshih@realtek.com>, Ryder Lee
 <ryder.lee@mediatek.com>
Date: Tue, 13 Feb 2024 09:42:12 +0100
In-Reply-To: <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
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

On Tue, 2024-02-13 at 10:46 +0530, Aditya Kumar Singh wrote:
> On 2/12/24 20:16, Johannes Berg wrote:
> > So ... I'm looking at the client side, and thinking about that.
> > According to the spec, multi-link element should be present in beacons
> > of APs affiliated with the same MLD if one of the (other) links is doin=
g
> > CSA, and then have also the CSA counters of course, relative to the
> > target link's TBTT (of course.)
>=20
> Yes correct, you are referring to critical update(s) right?

I was actually thinking the critical update flag is rather not all that
interesting, but the inclusion of the CSA-related elements in a
(partial) per-STA profile in the Multi-Link Element is. Those contain
the countdown fields, so need to be updated - according to the TBTT of
the link doing the CSA, not the link sending it.

> > Theoretically, both mac80211 and hostapd today support different beacon
> > interval on different links, I believe.
> >=20
> > This makes the whole thing of including CSA for link A on beacons/probe
> > responses transmitted on link B very tricky, because you have to know
> > the timing, etc.
>=20
> At least handling for probe response seems to be a bit easier since=20
> there we need not maintain any timer as such (as you have said too - we=
=20
> need not be perfect there).

OTOH, if we already need some infrastructure for beacons, we can also
use that infrastructure to fill in probe responses? Might be easier
overall, because otherwise you'd have to start timers in hostapd etc. if
you actually wanted to fill that in hostapd, and that's messy ...

And as a complete aside: link removal _also_ has a countdown, but I'm
not sure that affects cross-link, but if it does we might want a more
general cross-link counter infrastructure? Though that might not mesh
well with how (your) firmware handles it?

> But beacons, as you said, it is indeed bit=20
> tricky to handle full support considering both links could beacon at=20
> different intervals.

Indeed.

> > For the CSA counter of a link _itself_ we have counter_offsets_beacon
> > and counter_offsets_presp (for probe response offload) in struct
> > cfg80211_csa_settings, and also counter offsets in struct
> > cfg80211_mgmt_tx_params for sending probe responses.
> >=20
> > But ... for the cross-link information in the MLE this gets way more
> > tricky? Especially if the beacon interval is different - we couldn't
> > just count down, we'd have to fill in the information when we know wher=
e
> > the frame is transmitted. For probe responses maybe we can afford to no=
t
> > be perfect, but for beacons it better be right - so we have to calculat=
e
> > the right counter value(s) for (all of) the switching link(s) according
> > to the current TSF, TSF offset and TBTT - not all of which we even have
> > in the driver?
> >=20
>=20
> Yes correct :)

:)

> > I can see a few ways of implementing this:
> >=20
> >   a) Punt to firmware and it parses the multi-link element etc. to
> >      find the places to update. But that's awful, it requires parsing
> >      possibly fragmented MLE with fragmented subelements containing the
> >      CSA elements inside ...
> >=20
> >   b) Punt to firmware and give it a (possibly long) list of offsets K_N
> >      where to put the N'th counter for link K when transmitting the
> >      frame.
> >=20
>=20
> At least for beacons if firmware takes care of it then it will be good.=
=20

Note that I'm basically asking you, Mediatek and Realtek how this should
work. We're almost certainly not going to support multi-link AP in our
device any time soon, and we could adjust the firmware to it anyway if
needed.

So while I agree that punting it to firmware would be somewhat nice, we
still have to agree on (a) or (b), because (b) requires more information
from hostapd etc., but (a) requires _substantially_ more (and very
complex) parsing in firmware... If you wanted to support multi-BSSID,
then it's even more complex, which would argue for (b)?

I was trying to keep opinions out of this, but personally, I really
don't like (a), it puts too much complexity in the hands of firmware
engineers ;-)

> Firmware could maintain the counter (for the affected link) and (I=20
> assume it will be aware of the partner links) so whenever partner link=
=20
> transmits a beacon it could add the CSA (or such IEs) in per STA profile=
=20
> of the reporting link. It could get the contents from the affected link=
=20
> but actual value of the counter could be filled from the global counter=
=20
> being maintained. But not sure whether we can force every driver's=20
> firmware to do so?

I'm not sure I understand that description - how would firmware even
know which elements to take from what partner link etc.? I think hostapd
still has to add the elements, and firmware would just populate the
counter field(s)? But yeah that requires knowing from which partner link
to populate.

If you really wanted the firmware to handle the partner link information
completely it'd not only have to parse the Multi-Link Element on other
links but also _modify_, and know what to do, etc. - I don't think
that'll really work so well.

Think about it some more: On the link doing the CSA you'd have to parse
the beacon template and understand where the CSA-related elements are
(CSA, ECSA, Channel Switch Wrapper, possibly more?), and copy them
aside. Then on the partner link(s) parse the Multi-Link Element, see if
there's a partial STA profile already for some reason, merge the CSA-
related elements into that, update the counters; all while first
removing the 2 levels of fragmentation, and then re-doing them ...

I'm not even sure how I'd implement that in hwsim, and there I already
have all the helper functions and pretty much unlimited memory/code
size, so doing it in firmware seems awful?

Not to mention that it would never extend for future stuff, since new
elements wouldn't be copied over, firmware wouldn't necessarily know the
right order to merge them with existing elements in the per-STA profile,
etc.


> Let aside actual drivers, adding the test case for mac80211_hw_sim would=
=20
> also be tricky since there beacon Tx is handled in software only.

Yeah but that's easy, especially if we go with (b) approach, even
mac80211 basically has all the necessary information to handle hwsim's
model of beacon transmission, we could add a little bit of additional
help there too (e.g. pass the TBTT to beacon_get).

> >   c) Require the get_tsf operation and add an operation to retrieve TSF
> >      offset (**), and then calculate the TBTT for each link when
> >      beacon_get is called with the per-link beacon intervals and update
> >      the values correctly if CSA is in progress on any link ... require=
s
> >      against parsing like in (a) or offset information like in (b), but
> >      at least now it's in software?
> >      For probe responses this could be a bit off I guess, but maybe tha=
t
> >      doesn't matter as much - probe responses are not authenticated so =
a
> >      client probably shouldn't use them for real CSA anyway.
> >=20
> >      (**) which I guess we need anyway for hostapd to put it into beaco=
ns
> >      etc.?
>=20
> Yes I'm too anticipating hostapd changes to support the critical update.

Oh hostapd will have to make changes here for everything - the (**)
footnote was about how hostapd knows the TSF offset between links?
Unless we're planning to always keep the TSF offset zero?

> > Do you have any plans for any of this?
>=20
> I do have some idea (possibly half baked code) for handling critical=20
> updates in probe responses. Beacons, I assume firmware takes care hence=
=20
> I have changes to mark it in the link_conf so that drivers could read=20
> that and give it to its firmware.
> Handling in beacon at kernel level, I need to think of it since anyways=
=20
> hw_sim test case is good to have :)
>=20
> Do we have any data right now, how many actual drivers have offloaded=20
> beacon Tx to its firmware (at least those who are supporting Wi-Fi 7)?
> If we could see majority are using firmware then we could first add=20
> support for such drivers then we can think about handling it in kernel?

I agree that we can go with one approach for now, but I think we should
agree on the first model of how firmware does this. I'm not convinced
that your description above where firmware even magically handles
propagating the CSA elements to partner links will really work? But see
above.

> > I'm mostly asking right now because I want a reliable way to test the
> > work I'm trying to do on the client side though, so I could also live
> > with some hacks (inject through debugfs?), but having it for real would
> > be nice.
>=20
> Okay. I'm right now working to add basic test case in hw_sim for MLO CSA=
=20
> (on first link) as we discussed. There is need of a few mac80211 changes=
=20
> in order to support for other links. I'm checking those now. Once done=
=20
> with these, then I'll take up critical updates.
>=20
>=20
>=20


