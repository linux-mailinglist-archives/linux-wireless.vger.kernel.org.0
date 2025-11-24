Return-Path: <linux-wireless+bounces-29277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB856C7F3ED
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 08:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C513A5EA7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7BC2EB5B8;
	Mon, 24 Nov 2025 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mwZvS6vk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F227FB26
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970452; cv=none; b=TuK1+u1WsNIKQghnNGBE9mCbEHs9qVpCamyb64q4eNiqtddaqsEvKyiwHHEoQmjZBeYNj0NXarU1MFy7KaAZE6fuW1YcSSTULc9SSJ/Zgd54JabJg90AZJ3fTc48GgeSnWFytq0oDZYnax7pA4ZioQhsQIFuwp0Y+vJISsy7xpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970452; c=relaxed/simple;
	bh=8ZpHfc2TdWQlmqcVIdbDAsW9jI6v4Ll6Me+n9yk39Nc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jVg7jtZ3CLLfHjuEJiZ7i66jNj5d4GySGUB6XAMZDb7WsY3vm1xJOFqPBEB1ZurW+gjD90pQXnhEWAqvfzItFBmvHO2+fMkl2D6pjkYiNZ3wWYe2+FNpI7JbsblFUJWdkDS0bQpBblv7G7gmWw8mOgDpSl06XE7TKxWwM77Sd7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mwZvS6vk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ATt+6/wWInnFmxI5PytpZYgw7ainQzaNuQH8MvlpluY=;
	t=1763970450; x=1765180050; b=mwZvS6vkuzXs4pJ8AHAPzKaDISrgffqy8PxtE3EjbfvOAcq
	9JaeMb7keU0a/6Pdy3mYA3tGcYv8y5KQ6M+qE39uJ5pWXRO+nlYm3wDtU3jD9siBtlJNLV34lu9yI
	e2eZWzVh3C94M1O+W5lsW0XZUS0kjrewPX6hXJ821JDaXG6/urF3IY41VJyhz3A1bIj41dF50rPuu
	+a5GJ9elvwY6EqAo84zIkA+lypvnkvZ1HEEq78g2f8sx+dkSCaPYvoGnG4sCf04BlI+zcFlDdACez
	jgXUlG023sicHuntSgokwPNXkaXQqfBUwTrUWX+QcPy4JtWPpHYtXjvWdRdtzIMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vNRIC-00000008J7r-3fWp;
	Mon, 24 Nov 2025 08:47:25 +0100
Message-ID: <b39b8cb5989fb1744b5c609d4d467b248f217de6.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 0/3] wifi: correctly represent S1G
 channels
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Mon, 24 Nov 2025 08:47:24 +0100
In-Reply-To: <tx5ss62hjgfuha57z67cefnbdmxld4wrxjeudghpojxpxkbtab@22b35kctcbti> (sfid-20251124_084104_948186_CFFA93BB)
References: <20250918051913.500781-1-lachlan.hodges@morsemicro.com>
	 <5ec4190eb06c2b3763b8eb9d114a200d07437c11.camel@sipsolutions.net>
	 <lf22zjgof4ysu4v3blfbt3kv54l75rdbw3pecknlmlq6kmokha@a64bzx2dtrdr>
	 <tx5ss62hjgfuha57z67cefnbdmxld4wrxjeudghpojxpxkbtab@22b35kctcbti>
	 (sfid-20251124_084104_948186_CFFA93BB)
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

On Mon, 2025-11-24 at 18:40 +1100, Lachlan Hodges wrote:
> > > =C2=A0- _cfg80211_chandef_compatible() (not sure about this regarding=
 primary 2mhz)
> >=20
> > This looks to require a similar S1G specific path like we did within
> > _cfg80211_chandef_usable(). Also zooming out a bit, may need some adjus=
tments
> > within _ieee80211_change_chanctx(). Additionally would be good to exten=
d the
> > unit tests for this.
> >=20
> > I will do some more research and testing here.
>=20
> So, I have been doing some reading here.
>=20
> Firstly, _cfg80211_chandef_compatible() is not used during the associatio=
n
> process as S1G doesn't require the same "upgrade" process to parse the
> various HT -> VHT etc. elements and ensure the HT chandef is compatible
> with the VHT chandef and so on. (This is obvious though otherwise S1G wou=
ldn't
> work at all :D)

True, it's overall much less complex :)

> The next scenario is channel context sharing by interfaces. This again wo=
uld
> be very similar to non-S1G - where as long as the primaries are shared th=
e
> channel context can be used (among other things of course):
>=20
> 	[...]
> 	if (c1->width =3D=3D NL80211_CHAN_WIDTH_1)
> 		return c2;
>=20
> 	ret =3D check_s1g_chandef_primary_compat(c1, c2, NL80211_CHAN_WIDTH_2);
> 	if (ret)
> 		return ret;
>=20
> 	ret =3D check_s1g_chandef_primary_compat(c1, c2, NL80211_CHAN_WIDTH_4);
> 	if (ret)
> 		return ret;
>=20
> 	ret =3D check_s1g_chandef_primary_compat(c1, c2, NL80211_CHAN_WIDTH_8);
> 	if (ret)
> 		return ret;
> 	[...]
>=20
> The above would then be in addition to all the common checks, such that t=
he
> control channel is the same etc.
>=20
> The problem is, as mentioned previously, adding specific S1G Tx/Rx rate
> flags within link_sta_info / ieee80211_link_sta such that interfaces
> using a subband primary (say 4MHz on 8MHz chanctx) can clamp their
> Tx and Rx is not super nice (This was briefly mentioned in [1])

Ah, right, so it could be physically compatible, but right now we don't
have a way to signal TX/RX on a "sub-channel".

> So essentially I have two ideas / queries:
>=20
> 1) For now, we could simply say unless the chandefs are exactly the same,=
 they
> =C2=A0=C2=A0=C2=A0aren't compatible for S1G. We don't even test this inte=
rnally, but we
> =C2=A0=C2=A0=C2=A0aren't the only users here. This would enable _ieee8021=
1_change_chanctx()
> =C2=A0=C2=A0=C2=A0to function for S1G, probably through an S1G specific f=
unction that we can
> =C2=A0=C2=A0=C2=A0extend in the future.

I'm fine with that, if you don't think you're going to have multi-role
and chanctx sharing, who am I to complain :) Might even already be the
case?

> 2) In the future if / when some basic rate reporting / S1G bandwidths are
> =C2=A0=C2=A0=C2=A0implemented this could be revisted to mimic VHT. Implem=
enting proper rates
> =C2=A0=C2=A0=C2=A0for S1G will probably require some time to figure out h=
ow to implement
> =C2=A0=C2=A0=C2=A0it cleanly.

Sure, also again, if you don't really need it (now), no point doing all
the work.

> Let me know what you think. I will also send some patches for the
> s1g_primary_2mhz in the chandef sometime this week.

Sounds good :)

Thanks for taking a look. Really I just wanted to ask about it, while I
was looking at it for NPCA I noticed that at least some cases seemed to
not be quite covered (e.g. as you say s1g_primary_2mhz, this was the one
that mostly caught my eye anyway.)

johannes

