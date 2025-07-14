Return-Path: <linux-wireless+bounces-25382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB83B03F01
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 14:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F51188CFEA
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE7246335;
	Mon, 14 Jul 2025 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dLzOikdv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D11DEFDD
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497448; cv=none; b=qM0hS6QT+M8SrjdxLoiL1FTlbm3QMVtw0evYG4qauv6S6Ts1pODQEJH1HlBkfqBncTo/c9yOmXmMb2dAIozOqplR5e9xJQZegMKtohkJSOA68D0bcd2B7ZHk9huFijINC+hywc/Lt8M/SewDQ7MSOOVNHQfVfTkhEDHRx4iYRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497448; c=relaxed/simple;
	bh=3+f1SMsepcYIfI0WMT9FLDTkYXNVuJ66tGsPdANYAyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YWyAx3u9V2whNVGyVezKeaOMwCdQJRlKKkEbCpqBdLJzleFz7hNt8PjqHJ3HVNtzAx6GdyoWLfs/5v215EY0lp4sI5cLWMP98zWdaNOvxuiA0EOr9XTWv1g+eXCEkXl2OhjYrW4XLfqClzmbA/TbjsNty3IKECf5yU2rxMHjUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dLzOikdv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pmNLtpIiZNLq1k3w9t8gztVS/oeOCA2BrerUAQ0EJyY=;
	t=1752497446; x=1753707046; b=dLzOikdv2jgkSOgFofmY0/6bT8H/nzQIABN7X+N0UyZBTQW
	crx3h7Y8CMzzdfecF49bLwhve8WJ0mYVQJZIHota21PCUpZ4v7cQqNl7hqvuCLR//dKUc0CMz5V79
	B6tIuTeL+1cmTrONMzAj+1UWOjO1kEXOCR5Mljc4/jejbJ34xQSmXxsnKZYlYIPBCorOfv74Qozrn
	28B5Tj/lZJEmZH7Ds9NtjWFIBm8TEu/fWZVql1Qikg79maiQevb0U85dpQVCOS99cvG2khspQ99wa
	Ym0akM1FGYXemVZv0bpSexPVfZImk4pucEyqB1GftSJnntqlU0wQuM40yLiWtmdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubIdn-000000045ci-1mQw;
	Mon, 14 Jul 2025 14:50:43 +0200
Message-ID: <fa265deeae5dedcc7e13cda8cccd9b42f85026d3.camel@sipsolutions.net>
Subject: Re: [RFC 0/5] wifi: S1G short beacon support
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Mon, 14 Jul 2025 14:50:42 +0200
In-Reply-To: <20250714051403.597090-1-lachlan.hodges@morsemicro.com> (sfid-20250714_071427_168904_8E2A2A44)
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
	 (sfid-20250714_071427_168904_8E2A2A44)
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

Hi,

So just to say this up front I have very little interest per se in this
feature directly, so I'll mostly leave it to you :)

> Preface:
>=20
> Previously, some work was done ~2 years ago to get short beaconing
> in the kernel but it was never successful. The patches can be found
> here:
>=20
> 1/2: https://patchwork.kernel.org/project/linux-wireless/patch/2023081009=
3556.33800-1-bassem@morsemicro.com/
> 2/2: https://patchwork.kernel.org/project/linux-wireless/patch/2023081009=
3556.33800-2-bassem@morsemicro.com/

Heh, I didn't even remember.

> There is something to say regarding whether this is "correct" as
> after all they are extension frames and while we feel this is the best
> approach when all factors are taken into account - ultimately it is
> up to maintainers to decide.

Seems reasonable to me, and anyway probably necessary so that we don't
regress.

> 11.1.3.10.2:
>=20
> "The value for the dot11ShortBeaconPeriod shall be such that
> dot11BeaconPeriod =3D n * dot11ShortBeaconPeriod, where n is a
> positive integer. This defines a series of TSBTTs exactly
> dot11ShortBeaconPeriod TUs apart"
>=20
> the value for n here is what we are denoting as
> s1g_short_beacon_period (another deviation from the naming
> within the standard) which represents the number of short
> beacons between each long beacon.

That seems slightly confusing - I've have interpreted a 'period' either
as a span of time (as in the spec), or the number of steps between
events, so maybe that's rather 's1g_long_beacon_period'? But if the spec
uses period as a span of time, then perhaps 's1g_long_beacon_step' or
something would be easier to understand? Not sure ...

> To keep track of the current
> state, we introduce a new parameter sb_count within the
> struct ps_data structure to track the current index into this
> period. This is what is used to determine whether we send a
> long or short beacon on beacon retrieval where a value of 0
> indicates a long beacon (following the same cadence of
> decrementing the DTIM count).

Seems fair.

> (4) Beacon retrieval
>=20
> There were essentially two options we could take with regards to
> retrieving the beacons:
>=20
> 1.implement it in the traditional beacon path via
>   ieee80211_beacon_get_ap
>=20
> 2.Implement an S1G (or maybe extension frame?) specific path
>   such as ieee80211_s1g_beacon_get_ap where the S1G specific
>   handling can be done in its own function, leaving the regular
>   beacon path untouched
>=20
> We have opted to take method (1) but this really comes down to
> maintainers preference. New conditionals will be introduced
> in the beacon path regardless and we feel this is the best
> approach but are open to feedback.

That seems reasonable to me, why bother the driver with the difference,
it's likely simply going to transmit the frame anyway, regardless of
what it is.

> (5) Testing
>=20
> This patchset has been tested on the following configurations:
>=20
> 1. Multi-sta setup with real Morse Micro hardware.
> 2. S1G hwsim configuration with a single AP and > 10 STAs
> 3. 2.4GHz hwsim configuration to test for regressions along the
>    non-s1g path consisting of a single AP and STA.
> 4. hostapd hwsim tests were run to ensure no regression for
>    regular 2.4/5/6 radios.

Cool.

> (6) Other notes:
>=20
> 1. The update mechanism is not really that nice. Though that may
>    stem from a misunderstanding with how FILS discovery and unsol
>    bcast update mechanisms work. Since short beacons rely on a BSS
>    to be configured we ensure that an update is only performed
>    when this is the case, and when the BSS has not been configured
>    we do not allow a set of parameters used for updating the beacon
>    to be used when the BSS has not been initialised. Would like some
>    feedback on our implementation here as Im not really convinved
>    it's the right way, but it seems this is how we currently handle
>    it. My understanding of an "update" is that we are updating an
>    existing interface. When an interface is being initialised, we
>    are not updating - we are setting... An option here is to just
>    not even allow updates since this is how S1G is done now and this
>    can be ammended in the future.

Noted. I'll go through the commits and shout if I find anything :)


johannes

