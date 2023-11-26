Return-Path: <linux-wireless+bounces-82-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761517F92D5
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Nov 2023 14:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985961C20998
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Nov 2023 13:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0ECD262;
	Sun, 26 Nov 2023 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iqEKsB0d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A1102
	for <linux-wireless@vger.kernel.org>; Sun, 26 Nov 2023 05:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sGtM2uHwgRQzBywqt5NLxY6NYUjZ2Q6OYC1uq8/v5PI=;
	t=1701004792; x=1702214392; b=iqEKsB0dev+4eTW+3Fkn/MCXthH9hexyZ9/c4ZGRH4QP/JG
	EWoKvpPpQwFcLAylO/lK4Mqw4Tsa1xhvwHCXn7t6zau2QF6aKVC12Tm+ka6XxjU1p10RhVx26OVd9
	Rtz8vubfqHGhI0KM6t6B/dgLFu8TC4AmZdpGtvtrX7njVIh2AybIcm1SST0Zcl5JC/k0sXZViPGwq
	zuOoaXDbFt6bQu5cZ60TXgi0+Iq/KxREUbgEx4FqxwmHybgBP4avAIoqRSWzbBGx/mYna7xSQq/U4
	MrWscplZq5JdNqMmwG296qXFyDRq5E0iE5WFCKJkHEEFb8hYlQU8jk2SpXDhkikw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r7F37-00000004wno-3xsM;
	Sun, 26 Nov 2023 14:19:50 +0100
Message-ID: <dffcbd379ede949e328076c5cffb42d442f0ba9a.camel@sipsolutions.net>
Subject: Re: [PATCH 4/6] wifi: cfg80211: Schedule regulatory check on BSS
 STA channel change
From: Johannes Berg <johannes@sipsolutions.net>
To: "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>, "Greenman,
	Gregory" <gregory.greenman@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date: Sun, 26 Nov 2023 14:19:48 +0100
In-Reply-To: <DM6PR11MB3897EAD2252F23EBAED8EC4EF5BEA@DM6PR11MB3897.namprd11.prod.outlook.com>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
	 <20231113112844.15d7a0ee3fda.I1879d259d8d756159c8060f61f4bce172e6d323e@changeid>
	 <782a4f7ac91dcb0e1c564e285051c63e2a95d71f.camel@sipsolutions.net>
	 <DM6PR11MB3897EAD2252F23EBAED8EC4EF5BEA@DM6PR11MB3897.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> >=20
> > > +void cfg80211_schedule_channels_check(struct net_device *netdev) {
> > > +	struct wireless_dev *wdev =3D netdev->ieee80211_ptr;
> > > +	struct wiphy *wiphy =3D wdev->wiphy;
> > > +
> > > +	/* Schedule channels check if NO_IR or DFS relaxations are
> > supported */
> > > +	if (wdev->iftype =3D=3D NL80211_IFTYPE_STATION &&
> > > +	    (wiphy_ext_feature_isset(wiphy,
>=20
> We do need wdev here,=C2=A0
>=20

Oh right, I missed that, sorry.

> I will change it to be wireless device instead
>=20

No need I guess, if we're only going to check for it being a station?
Would we ever have a reason to call this for a p2p/nan device? I guess
not, since that doesn't affect regulatory in the same way?

johannes

