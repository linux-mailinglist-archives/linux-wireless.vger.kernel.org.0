Return-Path: <linux-wireless+bounces-36218-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULW6EienAWrlhQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36218-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 11:53:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8F450B625
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 11:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD50A3030D3C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8F43BD22F;
	Mon, 11 May 2026 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="UddFC1zg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D31309EFF
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492388; cv=none; b=Y3Q+Tl1yr4VukJBgeCDhJHUMxRvNLJMmvyr9MnXMbSqTRra33CNXu+jcU5DPrqyVgMo3+twWRm6qVN7uWW/oXcd4l/PXT3Y63Vcdi0u0lVmvp7AI5WZkI/BJwlnE/bZnKIIifrtwKKJsREg78MFQyCkYZ+xeQ/vXaSVn0zlNoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492388; c=relaxed/simple;
	bh=FpmTRt0DeAO1mjkwFi6CDNJMrLEuiJtPudFzOx0q38U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwPV7bIz+4Fpl7C07mfiBHur0WXkVxi/EWl5wOPpXSrLdQJUJ2N/mqplIT3KNsMr7Ne26I5oF5JwwTU8F20f2NphpCi66mZZLaII7YUJQ6w7Nt6t0MLnl+6tguNEroBMp/RFTJIya2496CchFTbkXtXCGggTxQlBLMKi04Kfmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=UddFC1zg; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EeDpz+YJE4DbD3Hs6D+EwZzUh/nYE6TAk4hUn+pN7aE=; b=UddFC1zg4c5vClH0uqRczQ6VAu
	G74p1bNedfdRkQF/VCDF4fCwkVhCUWWGtlR6c3QcPgPXvltloqkm+DYi91YspOysYBcnIEs8ywPBS
	VQsuIy2C2vswqemO+xOO+uKiEK7TSIM90F5IcDx7j64nI2e9rKAMuU3js+NpanoL8AKSytaU4RSFU
	NkraWgFVlMtgKhTYqj+14vjfX+gMvuO7J6rwQ2kp7Koya6088BgDUbG0myhKMy2h1J6zxNNSf3CBQ
	xxYV+soMmzdCAJTI0BRfdUgiglZwi4IzYjHQc3Hy0bxvfKlCCvaIv52XkS6aujL9f5P8NahwmzAVa
	kA4/FCmw==;
Date: Mon, 11 May 2026 11:39:35 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Peter =?UTF-8?B?w4VzdHJhbmQ=?= <astrand@lysator.liu.se>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wlcore: Add support for IGTK key
Message-ID: <20260511113935.6c1eb38f@kemnade.info>
In-Reply-To: <a2040dcc-af47-1de0-b731-defffe3ce4cd@lysator.liu.se>
References: <0d3df7ab-6c41-c3cc-83cc-5ba55fe4e4bd@lysator.liu.se>
	<20260508102403.4e2fb1bc@kemnade.info>
	<a2040dcc-af47-1de0-b731-defffe3ce4cd@lysator.liu.se>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9A8F450B625
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kemnade.info,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kemnade.info:s=20220719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-36218-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreas@kemnade.info,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kemnade.info:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,liu.se:email,kemnade.info:mid,kemnade.info:dkim]
X-Rspamd-Action: no action

On Fri, 8 May 2026 15:55:07 +0200 (CEST)
Peter =C3=85strand <astrand@lysator.liu.se> wrote:

> On Fri, 8 May 2026, Andreas Kemnade wrote:
>=20
> > Hi,
> >=20
> > On Fri, 16 Jan 2026 18:58:58 +0100 (CET)
> > Peter =C3=85strand <astrand@lysator.liu.se> wrote:
> >  =20
> > > This change re-applies commit 2b7aadd3b9e1 ("wlcore: Adding suppoprt =
for IGTK key in
> > > wlcore driver") (sic), but only enables WLAN_CIPHER_SUITE_AES_CMAC wi=
th modern
> > > firmware. This patch is required to support WPA3 connections.
> > >  =20
> >=20
> > I have seen this after this patch:
> > [  484.113311] wlcore: WARNING could not set keys
> > [  484.117828] wlcore: ERROR Could not add or replace key
> > [  484.123016] wlan0: failed to set key (5, ff:ff:ff:ff:ff:ff) to hardw=
are (-5)
> > [  484.123046] wlcore: Hardware recovery in progress. FW ver: Rev 7.3.1=
0.0.142
> > [  484.139923] wlcore: pc: 0x0, hint_sts: 0x00000048 count: 1
> > [  484.145721] wlcore: down
> > [  484.148986] ieee80211 phy0: Hardware restart was requested
> > [  484.610473] wlcore: firmware booted (Rev 7.3.10.0.142)
> > [  484.633758] wlcore: Association completed.
> > [  484.690490] wlcore: ERROR command execute failure 14
> > [  484.690490] ------------[ cut here ]------------
> > [  484.700195] WARNING: drivers/net/wireless/ti/wlcore/main.c:872 at wl=
12xx_queue_recovery_work+0x64/0x74 [wlcore], CPU#0: kworker/0:0/892
> >=20
> > This repeats endlessly.
> > As soon as I set pmf to 1 in wpa_supplciant, once per second. Reverting=
 this patch helps. Seen this
> > on the Epson Moverio BT-200. =20
>=20
> Thanks for this feedback. From the firmware version, I assume that this i=
s=20
> not wl18xx but probably wl12xx? Unfortunately I have no experience with=20
> that module. So, while my patch is an improvement over the original patch=
=20
> because it checks firmware version, it did not consider non-wl18xx=20
> modules.=20
>                =20
This is:

compatible =3D "ti,wl1283";

Regards,
Andreas

