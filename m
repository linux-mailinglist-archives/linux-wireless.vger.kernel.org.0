Return-Path: <linux-wireless+bounces-2694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B611D8412BF
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2A31C247BE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D67F46A0;
	Mon, 29 Jan 2024 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="t+oH+NuW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD776C63
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554378; cv=none; b=DYxESDAuchMcHgJ98aaKzbNcQVSrk1z/k/CGAfM/q9DcCeoCqvERs7iaOfcmPzkMW6n1MrtKveM2w+DaKFZk1xBB2B/V2hmhY4Y22NZiLIaWsCRRlobCZMSyIUT0g9ajBI8RQHkyLPgwyNzyGqm8tdPUwZ6ZbkgrJjPjT1Nzdwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554378; c=relaxed/simple;
	bh=MPo6J4G0A4Si5X2WwBNam/D7oS67gBGoFjZ4Cbw40Ko=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d7MxwyfzQZnN6pZywM+1MHdwG2rsRIbc0MJUOvsN1tp3gp6od2DTu8Sz8il3P5oJPBn+S2ggkTlXGzy7/+64l69LOmIyqA9q4kAR4cFyWrFptGbP4lCx3KBYoZ8By8Si7lcJsJbUEZnt6Z1fo2KXjveleg6nFCILTly+KvU3tg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=t+oH+NuW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PXCPxbxH1gNhopFmCYJpLQEVYjF1EbcTdCrksC+lIWk=;
	t=1706554376; x=1707763976; b=t+oH+NuWrsk90MoWTcLnKK/7pzFi9TRL3IcubNv5y6WODIF
	TtAgFn7u3j3GK4f3GZxREP9ulGxE7EexcqbfVVoj0PoxD3vKoNfXFDFSz4cORvWtYEf1mT09TRU4+
	HVKIn/cM+UpbZcSnuHJMVPO0/va2OuQ/2zKGGo8/pJzF2LgoVT1pE2XqDXTnHav4u1jQtfO8ONByq
	3zSPGfWvH13NTgukfdBbxfPk2h54XECrMohp35XEG6hxcGLvfFghBOs2tqAtFZjedbVIaWUvMBSUa
	gIUB5hql7bPrC5mUTPPXD4uLWcm85HS+juScXeKl0dZ17RmbHVugDLU+ne3O9joQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWkY-00000004zeo-2NKr
	for linux-wireless@vger.kernel.org;
	Mon, 29 Jan 2024 19:52:54 +0100
Message-ID: <f3d90154a7e98869f73a12d33593e452019bdf20.camel@sipsolutions.net>
Subject: Re: [PATCH 00/15] wifi: support wider-BW OFDMA and fix puncturing
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Mon, 29 Jan 2024 19:52:53 +0100
In-Reply-To: <7e0c33a964ad9c0b569c5363e2d5b70210154a52.camel@sipsolutions.net>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
	 <7e0c33a964ad9c0b569c5363e2d5b70210154a52.camel@sipsolutions.net>
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

On Mon, 2024-01-29 at 19:51 +0100, Johannes Berg wrote:
> On Mon, 2024-01-29 at 19:34 +0100, Johannes Berg wrote:
> >=20
> > As part of the refactoring to more clearly determine both local
> > and AP mode (HT/VHT/HE/EHT) and channel configuration, this makes
> > mac80211 a bit more strict:
> >  - no longer accept channel switch when the mode changes
> >  - no longer use e.g. VHT if the HT channel inside of it
> >    occupies the wrong spot (e.g. center 40 MHz inside 80 MHz)
> >  - don't use EHT with bad puncturing (punctured subchannels
> >    cover subchannels that are used by HE)
> >=20
> > Hopefully these things won't really break anything outside of
> > a handful of hostapd tests seem misconfigured (e.g
> >=20
>=20
> Err, sorry.
>=20
> The tests that are broken are mostly because of the first bullet, and we
> had fixed this by:
> https://lists.infradead.org/pipermail/hostap/2023-December/042218.html
> but (IMHO) the justification was bad - I'd still think it's weird to
> switch off e.g. EHT completely during CSA, and certainly mac80211 makes
> no attempt at tracking this and reacting to it (e.g. updating rate
> control to disable EHT rates), which is why I did the change to not
> accept it, and disconnect (which should lead to reconnect).
>=20
> The EHT puncturing tests are broken because of the last bullet, and I
> had fixed that in a patch I just sent to the list,

https://lists.infradead.org/pipermail/hostap/2024-January/042316.html

johannes

