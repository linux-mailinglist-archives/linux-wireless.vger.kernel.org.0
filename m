Return-Path: <linux-wireless+bounces-17483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE4A10523
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 12:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0623F188760A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1141020F978;
	Tue, 14 Jan 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gGHa0imV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCFF20F960
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853594; cv=none; b=XPqjrB8f11BLH+HW2yfWgf43OFHhzwwhYpTNmu0kkq+f7gcT9fQLsY970628qe/wuzpLbVQn+c7hGUVD4JZ7IgnjiMZawpEGkkKW0R6NtIZ+29PEt3SU8dFJeQrNuvyPvSKjuGQuqy+yRXzZBhz2DoK/8mSXKxD/dsSquxLdREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853594; c=relaxed/simple;
	bh=eqUQRkCUEHLkvAgMQwgM0hO8OSvIwRUgkcdZtk69tGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kU1O3zJAJj5Oq3sNn42Z8qOtIbG6IXPHlFsHE7Mtij9igRPG/vgoA70pmKWQ2FcYvTldjmTVwHd6bqsFhF9UN3OZxWnqNv2CymSu81uNYqKg7a26EJV2clWZQ12APX6xPR9L/RhG7pod5Limr/BG/b5qdLlcVrrmfz7z+OuVJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gGHa0imV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PEL5N9EP13EkLVRf+alYy55q/NjFIvdjYMeXnjylOnU=;
	t=1736853592; x=1738063192; b=gGHa0imVY9oKswbcaXst2HsSja3I2l9rObR38U4ha17AotB
	7J/hQ5yqPtVdwm5dGnQ7PJUbme+/SXuqknivjqMwg40/wdeA7xXH/oKSsXjkrlfWB3ZpL9TkpXa/W
	nC84JDmu033BQvS0M51KsqUJOTaoGMGM+/A0nEV7kZVJTy5lRFoJTaipEvY3XKC2UWtyjR1/66XXA
	xoUM3Rgsc5W99Mj7Edf0GGYnEnhPQve1LxLTNHud1bPhuLkY6LVW7O5OTyRVMrkxDE1rksv0FvYWY
	Cl1S+6axgJzswLPPz8ZPoXkI/0fRnyGaUmLPfHbe0UmFRrR2lk+C0XEs2Aea11xQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tXexR-0000000EZ1n-42dg;
	Tue, 14 Jan 2025 12:19:42 +0100
Message-ID: <f8de2e7127b7a79e259bf14c62c4eb0ef25ddfb6.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 2/7] wifi: cfg80211: reorg sinfo structure elements
 for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 14 Jan 2025 12:19:41 +0100
In-Reply-To: <3d18b02c-3f70-43a5-b825-0d191336a3e4@quicinc.com>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
	 <20250110042449.1158789-3-quic_sarishar@quicinc.com>
	 <2f3a8f1c5e9dd41ef38e7dc7cf9411d00313a806.camel@sipsolutions.net>
	 <3d18b02c-3f70-43a5-b825-0d191336a3e4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-01-12 at 13:40 +0530, Sarika Sharma wrote:
> On 1/10/2025 2:49 PM, Johannes Berg wrote:
> > On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
> > >=20
> > >   struct station_info {
> > >=20
> > > +	struct link_station_info deflink;
> >=20
> > Having a deflink here seems kind of questionable?
>=20
> ohh! why so? In other structures like vif, sdata, sta, we did the same=
=20
> way. So why can't we have the same way here as well?

Well, (a) I tend to think in hindsight it was sort of a mistake, but (b)
we couldn't really do it differently due to all drivers. But here you're
already touching all the code anyway, and it's mostly cfg80211/mac80211,
so why bother?

> > Why not pass multiple pointers?
>=20
> Sorry, I didn't get you.
> Did you mean keep the sinfo structure and call this for filling all link=
=20
> level, non-mL, ML information?

I think I meant that we could have per link pointers passed to the
method, but we might as well just have them in the sinfo struct as you
introduce in later patches.

> > > -	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
> > > +	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
> > >=20
> >=20
> > A little less renaming would probably also make this easier to review.
>=20
> Sure, but this is corresponding to filling link level data, that's why=
=20
> just renaming sinfo to link_sinfo.

Yeah, but does it matter so much? :)

I guess the flipside is that this way it's easier to review that all
values fall into the right place, but I think the data structure
organisation you did mostly ensures that anyway? Not sure though.

johannes

