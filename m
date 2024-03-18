Return-Path: <linux-wireless+bounces-4834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B525987E68A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 10:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B6C1C20D9E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFCF22EF2;
	Mon, 18 Mar 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ji5Mj3Ud"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9A224D4
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755934; cv=none; b=Gmgj2ROffxeEz7Q+pnqHaRARawhWnqwMawjjWAxVJzD/yBPA5VF1kSF/N6nMG8j7kGURnmm1mmGxfxOSxZu7p+HUhoRs6UsTxozdrt8Ryzlg2i1MFsYfEjPu8L94FLhOw+Lx1OXVJiE3WiKKf/LUqgHZU9crskizsGRIPX9fpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755934; c=relaxed/simple;
	bh=csfmczM5/cwjGO9e2ay9WuOK1aFkU/wrm+Vj2UzurcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iUR65oLOL53qbFb+yrnEMeOpexR50vzjcm1ymgtkSML7KkMD+ez9CSJZlaa7vfVDT+8BeIi9c1gwCVo0MOaVHbqF4m1IeFuO0VkOOIBrWBSUHEi8Nao1ItsTpCYKOJAW/Ci6zBiOlzxsau/1L7w9TTmTIz7CgXDoPNaGQHA6PCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ji5Mj3Ud; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=seFSEx9cMzcbKESR/mXnsaQ9AMbLOHyD7PKWsZr7w04=;
	t=1710755932; x=1711965532; b=ji5Mj3Ud1b520lYqcY3Ghh9vHBzGs6AuKEHORNOr8W7YX2f
	80CozHaKq/jNE9RcveZdGnBjHvng1jlJYXMjC+f7JYl9hUH02bcdtpN4imnm+ETscADpu/D0OhTKi
	zv/YAkQfcyECPNKaTFLethy3SiRb2cGZuKFvZok3DF6cyv4vZ3iL5oGQnNGShQU6cr9B9o+rGFZUf
	6vBzCAajqbLEt+Kdww2MHfQo9drVQ/wOG4mSyh5CEQgOFvLYgFgi/UsQddD9NQklTbYMssb0UkZpg
	P+9cDfZfgJ+fCyfg5eiBpANtMAZVAJYOJurpoS5cY1vviMl/BGgyD3/gyTF8yAGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rm9lZ-00000004Ahu-1nEZ;
	Mon, 18 Mar 2024 10:58:49 +0100
Message-ID: <52d4ad82257001925849a34aa9fd717046208e26.camel@sipsolutions.net>
Subject: Re: BE200 - 6.5 backports - disabled EHT issue
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Date: Mon, 18 Mar 2024 10:58:48 +0100
In-Reply-To: <CAFED-jkowv0GTtWUC3=HwGNjzwe8d2F-m_QrZratdpA5HnkuBA@mail.gmail.com>
References: 
	<CAFED-j=3_xLuJFp5R_gThMtv2C6r6WzRxzrY3_wjFTn=XJQLwg@mail.gmail.com>
	 <bb884b84dbaa1c97f9d3a1e610f98ec6e069a706.camel@sipsolutions.net>
	 <CAFED-jkowv0GTtWUC3=HwGNjzwe8d2F-m_QrZratdpA5HnkuBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2024-03-17 at 10:53 +0100, Janusz Dziedzic wrote:
> pt., 15 mar 2024 o 19:04 Johannes Berg <johannes@sipsolutions.net> napisa=
=C5=82(a):
> >=20
> > >=20
> > > I see this one do this:
> > >  if (!ieee80211_verify_sta_eht_mcs_support(sdata, sband, eht_oper))
> > >       *conn_flags |=3D IEEE80211_CONN_DISABLE_EHT;
> > >=20
> > > Testing on openwrt and using backports.
> > > Is there some patch I can easy cherry-pick to fix it?
> > > So far just disable ieee80211_verify_sta_eht_mcs_support() check and
> > > BE200 works in EHT mode correctly.
> >=20
> > Then either the code there or the AP is broken?
> >=20
> > That function checks that the client supports the MCSes that the AP
> > requires. If it lets you connect without them, then it's broken. If the
> > checks there are wrong, the code is broken :)
> >=20
> > I guess you can capture the assoc response frame and we can check
> > manually.
> Added such dbg:
>=20
> printk(KERN_ERR "%d vs %d, %d vs %d\n",
>                                 req_rx_nss, have_rx_nss,
>                                 req_tx_nss, have_tx_nss);
>                         if (req_rx_nss > have_rx_nss ||
>                             req_tx_nss > have_tx_nss)
>                                 return false;
>=20
> [   70.243183] ieee80211_verify_sta_eht_mcs_support nss 4  -
> (ARRAY_SIZE(req->rx_tx_max_nss))
> [   70.248336] 4 vs 2, 4 vs 2
> [   70.251035] disable EHT due to mcs
> [   70.260724] wlan1: send auth to ....
>=20
> AP have 4 NSS.

Which doesn't just mean it _has_ 4 NSS though, it also means it
_clients_ to have 4 NSS, if I'm reading the code correctly? So we
correctly don't connect, and the AP incorrectly lets us connect if you
hack out the check.

Arguably the AP should not even include 4 NSS as the minimum
requirement, but of course it can, if it really wants pretty much no
client to connect (in EHT) :-)

Unless I'm misreading the code, but it looks pretty straight-forward.
Check what wireshark says about the EHT operation element?

johannes

