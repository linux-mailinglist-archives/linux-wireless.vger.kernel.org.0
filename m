Return-Path: <linux-wireless+bounces-31007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B64D3C0E5
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 08:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0B72427269
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530DEB67E;
	Tue, 20 Jan 2026 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XWVAdvhJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D850095A
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895410; cv=none; b=h+yiT6nAjCftFmR+teOMw0R5Rgu1vc811sX6YIBvOhTu1U9rMPiKcs+8q+vVu//Q4T+6VBZyOM9LCHYJDlujLKqjRZ1xaiTNNZ1HWkobOOK2BHHc73wiLG9sz9J1NOsDF8zgL7ZihdhrJpGQeKLJTItwgtdm3TN/ZSge1VGjj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895410; c=relaxed/simple;
	bh=r/ofrGGn2P+N/9ydPqWOihh4CZnEn6oKCEz6/UIr8EI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y72ZSS6bvEuL0T3Ay3AyKWke5VYkojfCj3RAktu7ASgVDa/9yq2g2kj8uyO3uOEIHsDCWQNetQ+Gj5ZeYk8sUVPGWvGPnhfU7q/GpHtLoVZDFq3eiZL9QmMZPOA43jPeOaqtJOhSVHmKQrnvCRFzzOGQNChUFs0FgOf/x52a4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XWVAdvhJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7oonuWWtECa5rOEJP/2tO742uxHd3Uj9r0q8ER2BmuE=;
	t=1768895408; x=1770105008; b=XWVAdvhJmJo6p6RALOhZlBvxq3JxPw1kjWlqaPeeqvLKkzG
	jcJW0QCe51fECKJeuQ5fqmptXIAB5up6CceGCqxU6x0VPbn8jxfrKtJs1gJnW7E7OqNazVK2qEj2/
	wXnAz0nw/EgWrM4+xxPGjsqKkuMY51B9W/bU4vPOtQVFkjt3j43Boi2X9pHD55y0CXnZptevH6zXQ
	eF8r89RJhJuBIz55Md3b4IUbj+UnD/hKiXz3KXqk+g8sYNJRJ1IYQG7qSF9d7212uKe31tcKM0LyK
	EaC//nRvLhATKGNUwh0sBE0m2GAA5Pcaomyz1a8vhXscr47o3WtrLQI36bGuvuNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vi6V3-0000000Gh68-3ewQ;
	Tue, 20 Jan 2026 08:50:06 +0100
Message-ID: <4dd2558fc13dd974bf551653b3db9c70feed73fe.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: cfg80211: don't apply HT flags to
 S1G channels
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 20 Jan 2026 08:50:05 +0100
In-Reply-To: <tyreg7kb5ownpgrbcwo72rk5tevk6jpzbthtlqr5z5zykvhaji@wpybm6oversy> (sfid-20260120_062241_374294_7F45D849)
References: <20260113030934.18726-1-lachlan.hodges@morsemicro.com>
	 <csqd3cp5twlhfsrkrppe25q2xby6wb37fhtxfrzgffjzoww2hw@xcixpwzlxzmi>
	 <14bc5d3362b071c7c7a6a64724d5b354c173a501.camel@sipsolutions.net>
	 <tyreg7kb5ownpgrbcwo72rk5tevk6jpzbthtlqr5z5zykvhaji@wpybm6oversy>
	 (sfid-20260120_062241_374294_7F45D849)
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

On Tue, 2026-01-20 at 16:22 +1100, Lachlan Hodges wrote:
> > > Playing around with some 5 GHz configurations in OpenWRT it appears t=
hat only
> > > so much information can be conveyed and indeed there are configuratio=
ns that
> > > will be rejected by cfg80211 (or maybe hostapd in some cases, not sur=
e).
> >=20
> > Really? Got an example, perhaps even with hostapd log to see how it's
> > rejected? That clearly contradicts what I wrote above which I really di=
d
> > believe to be true until this moment ;-)
>=20
> Sorry, it is indeed cfg80211 that is not accepting the chandef configurat=
ion.

Maybe I still know something ;-)

> channel=3D165
>=20
> vht_oper_centr_freq_seg0_idx=3D171

> This is the result of selecting mode AX, channel 165 with a width of 80MH=
z.

Well, I guess that could be done in some countries, U-NII-4 goes up to
channel 177 inclusive? But not for Australia which only has up to 173
(according to Wikipedia, maybe it's changing, I didn't check better
sources now.)

> The GL-MT3000 using the mt76 driver with mt7915e driver (?)
>=20
> cfg80211              299008  4 mt7915e,mt76_connac_lib,mt76,mac80211
> compat                 12288  3 mt76,mac80211,cfg80211
> mac80211              581632  3 mt7915e,mt76_connac_lib,mt76
> mt76                   73728  2 mt7915e,mt76_connac_lib
> mt76_connac_lib        45056  1 mt7915e
>=20
> And for hostapd output (Sorry I don't have anything more verbose)
>=20
> Tue Jan 20 04:10:43 2026 daemon.err hostapd: nl80211: kernel reports: (ex=
tension) channel is disabled

Right, makes sense, it's at least saying channel 177 doesn't exist or
cannot be used, perhaps already on 169/173 depending on what the device
knows about U-NII-4.

> Tue Jan 20 04:10:43 2026 daemon.err hostapd: Could not set channel for ke=
rnel driver
> Tue Jan 20 04:10:43 2026 daemon.err hostapd: Interface initialization fai=
led
>=20
> where _cfg80211_chandef_usable() is (rightfully) rejecting the configurat=
ion.
> This simply appears to be the logic to generate the config doesn't cover =
this
> case properly.=C2=A0

Right.

> Anyways, I don't think this is all that useful too be honest,
> it just comes down to ensuring the static configurations are known especi=
ally
> since this range is specified as AUTO-BW anyway as per the regdom.

Yeah, or checking against the regulatory, or something ... but basically
channel 165 + 80 MHz isn't _really_ possible then, since the
channelization plan says then you should use 171 as it does now.

> > > I
> > > suppose what I'm asking is - how much do we need to protect usermode =
from
> > > this? Do you feel it's worth including a flag that somewhat emulates
> > > NOHT40+/-? I know much of that logic is quite old and S1G is "modern"=
 ... ?
> >=20
> > It's always nice to have userspace be aware of things, but I guess if
> > it's a configuration that's statically known to be invalid, it wouldn't
> > matter so much?=C2=A0

But I think in the case you describe above, userspace should well have
been able to, at least in theory, predict that this would happen, based
on the channel flags.

> > But I don't think I've understood the S1G angle - are
> > you talking about primary 1 MHz? Primary 2 MHz?
>=20
> Putting primaries aside and just thinking of operating - eventually we wo=
uld
> need a NO_2MHZ flag as India for example only has 1MHz channels.. however
> this is well into the future .. we first need to add support for other
> countries :').

:)

> But yes as you said since these configurations are static it's not really=
 a
> big deal and more up to userspace to be aware of it. I think what we have=
 in
> cfg80211 now is good enough and seems to be working well when integrating
> into an actual userspace stack.

OK, sounds good.

> > We just posted a lot of hwsim changes for NAN - better send yours soone=
r
> > rather than later ;-)
>=20
> Yes I have seen, lots of Wi-Fi 8 documents aswell so I assume that will g=
et busy
> soon too. Well see .. Lots to do!!

I don't think hwsim will get too many wifi8 changes, but yeah there are
a lot of things brewing now. Seems you (mostly?) got just ahead of it
though, so it shouldn't be much of an issue, I'd think.

johannes

