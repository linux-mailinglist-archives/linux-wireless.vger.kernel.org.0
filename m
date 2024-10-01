Return-Path: <linux-wireless+bounces-13357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1698B567
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 09:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D30281016
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 07:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64E1BBBE8;
	Tue,  1 Oct 2024 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xGp8zDel"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1311ACDE3
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767354; cv=none; b=ZLI71vE9YYHWah2N1l33aUC817vtRiDYUon91XJYSm09TnJYMhZYiJw2+UEVDHUT30bS17z1FxaYcofeioTM8/xAxUITrbLV++rAIutcX93vORzvYBi/i+c64wcrh9/l3u8m18y4yhCgDK8zVt3gG+f6a6SSeFOca6pmsYVRr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767354; c=relaxed/simple;
	bh=qmIbgPV59wJbsKWZJLti/ftYLxamgJthHQiO6UxYuag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KTRT847h3/a98sRTL+IHXR5kANWx66FAvuDpmDAAr3eBVqxgJTV6HK4CLZxeS4ikCflQcr67bGAAfVQPoelRSyuvzZrSdsltC3IOOY2j80ZoBBYp4WDfeu3N+/R+sUffDNC6O/wOsCqQrOenRfkzkgXAKSMbaDE9KufmlXKASX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xGp8zDel; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JFBeJ6MgT6zo4FyBxtLrxgVA2X3Qucidq9sPOh6rCn8=;
	t=1727767352; x=1728976952; b=xGp8zDel3AGq8t0FEeW2Fc3RT/ORky04ooTxg9xGz2eUsOp
	F3rMaOAhB0y4aETT3AFimxvjjll5ctINi0QQI2dL0DYBzTrTMB202B6ZsD3wLQioCvlvJtCKJ5Rxp
	ftVOxDM79i6I4SQKAZK2Pw43/bxDYWk2fsebOVTfgjKOlCUoMitRkVagUgvYzQEq6DadhKwuUJXvD
	MVXztyJZ8tIQTJs1KQ7cHap0LeujoXdVudQx43vkBUy2VA2X9P4wf9Q/PXkLJqhhPiu1qXG2/1UPp
	WhVWR3gAdFIcwpuIYzbzVWgvu9OBb2uEHeWxqt/rw2p0vQBDbaiMJCHkeJYrALSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1svXDJ-0000000EeNZ-11Lk;
	Tue, 01 Oct 2024 09:22:29 +0200
Message-ID: <c103db90ed53a75cae10baba0ae52dae85bf1c3f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix assigning channel in activate links
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Tue, 01 Oct 2024 09:22:28 +0200
In-Reply-To: <fd731cac-7182-4de3-afd4-0fc5892a9440@quicinc.com>
References: <20241001041518.2236297-1-quic_adisi@quicinc.com>
	 <0353d31db76afbd5d9bb2e7d42246ae3c8e14044.camel@sipsolutions.net>
	 <fd731cac-7182-4de3-afd4-0fc5892a9440@quicinc.com>
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

On Tue, 2024-10-01 at 12:47 +0530, Aditya Kumar Singh wrote:
> On 10/1/24 12:01, Johannes Berg wrote:
> >=20
> > > +		/*
> > > +		 * inform about the link info changed parameters after all
> > > +		 * stations are also added
> > > +		 */
> >=20
> > I don't understand that comment - you're not doing anything with the
> > stations here? And per the commit log it's explicitly _not_ after doing
> > the AP station. I'm not sure we should set up everything before the AP
> > station?
> >=20
>=20
> Okay let me try to explain the situation here -
>=20
> In the *if (add)* block, drivers are informed about the new links added=
=20
> via drv_change_vif_links().

Sure.

> For drivers like ath12k, we know which link=20
> is changing, but since the channel contexts for the new links aren=E2=80=
=99t=20
> available yet, the driver can=E2=80=99t determine which link the firmware=
 should=20
> create the interface for. This is because we have more than one firmware=
=20
> operating under this interface (grouped multiple hardware under single=
=20
> wiphy). Therefore, this notification isn=E2=80=99t very helpful in creati=
ng the=20
> link interface now.

Yes, you said that.

> Next, in the loop list_for_each_entry(sta, &local->sta_list, list),=20
> drv_change_sta_links() is called to notify drivers that the links for a=
=20
> given station (STA) have changed. Drivers use this callback to create=20
> the link stations after the STA has moved to the authorized state.

Yes, I also got that.

> At this point, the driver knows which ML STA and which link STA to=20
> create. However, to create a link STA, the corresponding link interface=
=20
> must exist first.

Right, you said that too :)

> Currently, it doesn=E2=80=99t, so the driver can=E2=80=99t add the link S=
TA.

Right.

But that doesn't explain the *comment*, which literally says:

   inform about the link info changed parameters after all stations are
   also added

but you
 (a) don't add stations here
 (b) if you're thinking about link stations, the link stations are
     only added _after_ this comment and the link info change ...


> Later, in the loop for_each_set_bit(link_id, &add,=20
> IEEE80211_MLD_MAX_NUM_LINKS), channels are added. At this stage, the=20
> driver will actually create the link on the interface at its own level.=
=20
> Since here using the channel information, appropriate firmware can be=20
> picked. For example 2 GHz or 5 GHz or 6 GHz firmware.

Picking "firmware" sounds very odd here, I'd say you mean "which device
to pick"?

> hmm... yeah true that. May be I will move this once the old links are=20
> removed?
>=20

I'd think at least that?

But also this seems to break out driver for other reasons, because it
initializes rate control somewhere here and needs a station for that.
Didn't look deeply into that yet though.

johannes

