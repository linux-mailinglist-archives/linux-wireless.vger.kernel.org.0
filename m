Return-Path: <linux-wireless+bounces-12166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2FD9627ED
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 14:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08640286838
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FFC17335C;
	Wed, 28 Aug 2024 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lnVrX+xn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3416BE06
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849819; cv=none; b=BraQvd8mGe3q92ryM2uMkbUnMREvOTzwEMBKEP7OgwTsfejD+nOCeiYTn1pc+BbqQwVevtX2H2fMscfaT1hTrb2sQckUTDLetCF4jgcSYW+zey53FH0PvIQLTQxo95Law7kbkw3wx7qswD4U2yl8AioYSTCls8seuAisouHn8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849819; c=relaxed/simple;
	bh=CXDhiXucoQYG1K5Ksao52yti/0LBF1edCLkDUD1DlEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HzzcH62Jm7T7dZWhUzITDkRcTmPG8tNuznC/4DKdGocJA1uy6dMkaN9DQ2rV5/Si+YAUxZek0/hjjdnWv3OqoPurXCXj5LMFWkISA+YJY715wwqBj1RIYcGVBw8eSsPcOeHtlabAEy2TaGVt0I0gYyoB0gJHVumTRlSyUB/PPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lnVrX+xn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IiNc5tif10wozULP4NfCt1/ykWsXqbgMFLtehoheYko=;
	t=1724849818; x=1726059418; b=lnVrX+xn7kOGqF1vqmjw/6ybywsMqR8C0mH4otF/jXYKWaH
	fcHYlGB/VoCnZpluAaWdR6nsbXPwl3TTtdlmxd9SrgP8eLiRPERjj9FAlWh1X90b5AOOi5QqJvDo8
	N8aS8KSifk8k5JbMgqCWezVvS1IRuOKp8UjZvpTcfKZH3T2eMvQ9d5InQKtCtmgvZbK0WfZHJGraB
	HtgjBnVtiNusYe3nQkolIT1Rbk8pVRpprF9gRpDwGb3mLQ9XQd6OBQXMzLz/HMhn6RNVYdoJ7lxCV
	9i7G2nGI4wHFohSfmT4m6a9hgtldeYzbkZbLfIh+3IOZjhyvzab5BD2U/dAnCyLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjIEJ-000000079Nk-18bJ;
	Wed, 28 Aug 2024 14:56:55 +0200
Message-ID: <1268ad6f22b61f1c9b3c7e20c45c1a0050aa3631.camel@sipsolutions.net>
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022
 fail, reason -52 - Part 2
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Stefan Wahren
	 <wahrenst@gmx.net>, Arend van Spriel <aspriel@gmail.com>, Franky Lin
	 <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
 SHA-cyfmac-dev-list@infineon.com, Hector Martin <marcan@marcan.st>, Kalle
 Valo <kvalo@kernel.org>
Date: Wed, 28 Aug 2024 14:56:54 +0200
In-Reply-To: <9c763adf-56b0-4b69-b204-95d46c990656@broadcom.com>
References: <d9c9336a-6314-4de9-aead-8b865bb30f05@gmx.net>
	 <cb07408d-af14-4b01-bd96-15c480989643@gmx.net>
	 <5c462fac-b27d-41c0-a62c-a8951bf445d2@gmx.net>
	 <d8f7dc94-40f5-4544-9693-01d7cbc6fefb@broadcom.com>
	 <ca0fd1c5-380d-4756-a33a-cb6c84014ce4@gmx.net>
	 <89d3f34a-3427-4871-971c-d960a16918ac@broadcom.com>
	 <004dabc3-c345-4d90-9348-5caa9b1f3849@gmx.net>
	 <c3996f70-bb2a-4d26-a7e9-a1b062fa0474@broadcom.com>
	 <0e5eba2f-e524-4f0d-8217-2770c57ad5ed@gmx.net>
	 <18c8d7da558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	 <f3af378f-fae4-4a98-a5b1-24173d17b64e@gmx.net>
	 <18c921b1690.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	 <18c9224abb0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	 <d90cc093-e3fc-4af4-9a4a-5f4bd9a7cb1f@gmx.net>
	 <19541618e400c95a448f7e8c79590c01df214782.camel@sipsolutions.net>
	 <18d1388fbe8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	 <99977c876429f33d8dbab18d7c3e71590585263b.camel@sipsolutions.net>
	 <9c763adf-56b0-4b69-b204-95d46c990656@broadcom.com>
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

On Mon, 2024-07-15 at 09:54 +0200, Arend van Spriel wrote:
> On 2/13/2024 11:15 AM, Johannes Berg wrote:
> > On Tue, 2024-01-16 at 19:29 +0100, Arend Van Spriel wrote:
> > > > >=20
> > > > > I modified brcmf_construct_chaninfo() to store the
> > > > > IEEE80211_CHAN_DISABLED flag within orig_flags in case the flags =
had it.
> > > > > This avoid the issue. Not sure this is the proper solution.
> > > >=20
> > > > orig_flags are from when the wiphy is registered - does the driver =
only
> > > > set up proper flags after that?
> > >=20
> > > Long time ago we discussed about this. So brcmfmac provides a superse=
t of
> > > channels during wiphy_register() and none of them are disabled as the=
y
> > > could never be enabled. After that the driver may disable a subset as=
 it
> > > syncs with the device. I think we used strict custom reg flag, but th=
at
> > > seems to have gone. Could that have the result Stefan is observing?
> > >=20
> >=20
> > All this confuses me way more than it should, I guess.
> >=20
> > We do still have REGULATORY_STRICT_REG, no? And that sets even
> > orig_flags:
> >=20
> >          if (lr->initiator =3D=3D NL80211_REGDOM_SET_BY_DRIVER &&
> >              request_wiphy && request_wiphy =3D=3D wiphy &&
> >              request_wiphy->regulatory_flags & REGULATORY_STRICT_REG) {
> >                  /*
> >                   * This guarantees the driver's requested regulatory d=
omain
> >                   * will always be used as a base for further regulator=
y
> >                   * settings
> >                   */
> >                  chan->flags =3D chan->orig_flags =3D
> >                          map_regdom_flags(reg_rule->flags) | bw_flags;
> >=20
> >=20
> > But brcmf_construct_chaninfo() looks a bit more like it really should b=
e
> > setting a custom regulatory with all the channels listed, a bit like
> > what iwlwifi/mvm does, with REGULATORY_WIPHY_SELF_MANAGED?
> >=20
> > Maybe we should start from the beginning: what does this actually
> > _want_?
>=20
> Picking up this trail [1] after a long time (sorry).

Hah, same here.

> So the firmware has=20
> its own regulatory database. So upon connecting to an AP the firmware=20
> can change its country setting based on the country element the AP uses.=
=20
> In the driver we want to update the set of enabled channels. Maybe this=
=20
> is more or less what iwlwifi does?

More or less, yes. In iwlwifi it doesn't necessarily change when you
connect, but whatever, you get an event from FW when it changes, with
all the data, and then we build a custom reg domain to update the wiphy
with.

johannes

