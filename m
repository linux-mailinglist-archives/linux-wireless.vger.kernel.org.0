Return-Path: <linux-wireless+bounces-14560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D309B0FC4
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 22:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEF0284811
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 20:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C55D20F3F6;
	Fri, 25 Oct 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AmBqbuWH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8FD1925AB;
	Fri, 25 Oct 2024 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887947; cv=none; b=V/SNKIIOWmJkEM8qeTrMxmkJBbkm2yWHOVhaJszOibxIRrD/adHZ+B0Sgxq2RhkDTEzRU2C4lFg9slEzDBr0syKNA8GsXW5HbB/Jma8bdOgkhAUI9yZS9j9KQ+Xmn7XVkX/hKi5XDUJWCWEAdGKV+4iU582pIaHC9cMrlgEdpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887947; c=relaxed/simple;
	bh=+uvNZhiKMfXPyAmXlafRXJFnq8VZYZZxiNWopDKs70A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1lYFEFApe/VFmke3WzeboYQfqAUKnE+e+PLqChLZiRMUVESNo8WPIgzW3lO0zJZ8SzrEmBRpcRhxLoLzKlxHcsAYmUo+gSq0axE5EIkpz73w3fl/I/edyU0VOL915HEyn7mPmvXh4uUWp6ez7Leuy59k4Ra61ZXWBtxgLvRncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AmBqbuWH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mmfjn9qAXgCKtjiC5i7/9rC4rJePLAhu4PSD7Uub1g0=;
	t=1729887945; x=1731097545; b=AmBqbuWH0et39XBZpflftQjd2m15mIsR3Tcb/t7TW0vcPCg
	+cIOVSGxVNTl2f2Kx3rMPCVF9yZxLqiPwEkaL9KabtMy2H76rzEgf0WKGJ4wSh/hbIThy7aunpDPh
	oRZiCyrU+mZMSoOjEliLxkvS3tRhw2UMKXfDCoZ+3xrCsJ9Z6nBHYLzQkWUcGZW/Gv7ioatar7ga2
	BGFq9Ns0eiHQS+yUT8qK+GPX7Rn7nwnu08aeMc0V6UtJK5Mxa4pZBtKHxn4kWntL/tqJpvpFIeu+Z
	6FtNjsMUi4wOztruScYULkuvIn7pMYUitE7GhGXt/TVRzGWtiaxnbZokc5jV0H2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4QsP-00000004gmH-2Dd7;
	Fri, 25 Oct 2024 22:25:41 +0200
Message-ID: <5c48b4529bf552d5c16b4dcc951c653f37b6a68e.camel@sipsolutions.net>
Subject: Re: [PATCH][next] wifi: mac80211: ieee80211_i: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva"
	 <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Fri, 25 Oct 2024 22:25:40 +0200
In-Reply-To: <3471e59f-a414-479f-8fb0-aa1a26aecf16@embeddedor.com>
References: <Zxv7KtPEy1kvnTPM@kspp>
	 <c90c3c9825e3837bf7c47979acd0075b102576ce.camel@sipsolutions.net>
	 <3471e59f-a414-479f-8fb0-aa1a26aecf16@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-10-25 at 14:22 -0600, Gustavo A. R. Silva wrote:
>=20
> > > -	struct ieee80211_chanctx_conf conf;
> > > -
> > >   	bool radar_detected;
> > > +
> > > +	/* MUST be last - ends in a flexible-array member. */
> > > +	struct ieee80211_chanctx_conf conf;
> > >   };
> >=20
> > Oi. That's not just a warnings problem, that's actually a pretty stupid
> > bug, this will surely get used and radar_detected will alias stuff that
> > the driver puts there - at least for drivers using chanctx_data_size,
> > which is a couple: ath9k, iwlmvm, mt792x, rwt89 and hwsim.
> >=20
> > Could you resend with a description that this is a bugfix and
> >=20
> > Fixes: bca8bc0399ac ("wifi: mac80211: handle ieee80211_radar_detected()=
 for MLO")
>=20
> Yeah, I was actually going to mention this commit, as it's the one that i=
ntroduced
> that `bool radar_detected` to the flex struct. However, it wasn't obvious=
 to me
> how `struct ieee80211_chanctx_conf conf` could overwrite `radar_detected`=
 as I didn't
> see `conf->drv_priv` being accessed through `struct struct ieee80211_chan=
ctx_conf`.

You have to look at the drivers, see hwsim_clear_chanctx_magic() for
example; I wonder why hwsim_check_chanctx_magic() never caught this.

> > please? Or I can do it myself I guess, but ...
>=20
> Sure thing. I can CC stable as well.

Thanks!

No need for stable, it got introduced in 6.12-rc1 only.

johannes

