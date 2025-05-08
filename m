Return-Path: <linux-wireless+bounces-22735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1D9AAF693
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 11:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AE41C04AC6
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54236256D;
	Thu,  8 May 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GayREtYN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC65198845
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695840; cv=none; b=lSyO2vkptdDBwh9KxUP0S9DvAoe+iwgXN0ZZ9jBat4LeclbKs6zkLu+hobSeVlGZBQDInR0UymeHti+QUsNH1nmfSDecbM7o5+ScutbEJbtkZcyuIlroAbwBve/yNAUGbjbcTtDWxqpRllR+Zw6RoSV0efy6phBoDfIOOg2Um00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695840; c=relaxed/simple;
	bh=7/Um/iucCim0UgvHZGdvYSvTxZjqEciM9ZJCZ/tDtSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=szpwX3B+qq9bg5Zz5MSOegsP/pUMEr2pJINlb/xsJ3Xc/NhPCL7yrLfMpHYZr+55uLgwpvJCEKPQW0ko9BH8ssLZ74NUYsP2YaFLZ0xLXm1M3ZySWiK6pjcqLmKkEpkkRjkXzVP0qjGql3a0ugREX75RmHFpmHmCsIcl2AGwvhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GayREtYN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=G81Ct8Fo/XTseLehakG8JH35NItJdwxUxcPdND8TfVI=;
	t=1746695838; x=1747905438; b=GayREtYNyFaBnAAxIatRf3PK6Q7dCZvDvklYAZ8mLTV2ONS
	JSPUYPE7ocQJQWAQ9eYy0IsWArPrNKC2FNppXpjSAnbGMkB6f1mGuGvIg4UNUB8CA5Q3OrnGq83aM
	u8DFPqB4SVLWpYAILqVlg06Rc85HT8b7p69XhLRKBa2Ys4DIIzpPoMxz/KZFkOMzOEL05aG407qkp
	3RZpKGLpF6yb6VAVVcSP8HQnyAZUUWB/1SrUb6fC1+AnfL+lIa2F3jZHVT1KAnd1oVUVmCWt14dlI
	fxwF+a+nDHCRxzcmvXRi1C+pxAy+0P9AFsol1GJkh12jJOPJ6PssUZQpzBoWxTbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCxNS-0000000A15f-2vN6;
	Thu, 08 May 2025 11:17:15 +0200
Message-ID: <7a4a1d26e2c3905963fc5c7336fb5651a796a85f.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 00/11] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 08 May 2025 11:17:13 +0200
In-Reply-To: <14df6327-1a31-4ddc-a2b5-1055cbd5b686@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
	 <a12320b826ef7395bde044d9dcc7ad9f902c6ef9.camel@sipsolutions.net>
	 <14df6327-1a31-4ddc-a2b5-1055cbd5b686@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-05-08 at 14:34 +0530, Sarika Sharma wrote:
> >=20
> > But to be honest I completely forgot all the history here. Looks like
> > your initial patches couldn't even build, so I can't compare well with
> > what it would've looked like before.
>=20
> Oops! if require can send new version V7, in building state(as already=
=20
> prepared the patch as per last comments)?

No no, I meant *initial* patches, I was just trying to look at v1/v2/...
to compare how much driver changes they all needed, but in the earlier
versions you just skipped the driver changes entirely, so I couldn't
compare :)

As far as I can tell this version builds fine, the robot seemed happy.

>=20
> > We can also prohibit filling entries that make no sense for multi-link
> > statistics when provided on a global level, though honestly I feel like
> > for most of them we should actually provide some value, even if tx/rx
> > rate is just the best rate of all the links, or something like that?
>=20
> Yes, but then document for station_info structure needed to be updated he=
re.
> As for some of fields it will be similar for both non-Ml and MLO case.
> But some of fields like signal,rates, etc, meaning will be different for=
=20
> non-ML and MLO stats.

Agree, and maybe some of the fields should just be prohibited for MLO
(like signal/rate) until we figure out what semantics we want for them
for MLO. But we can document and implement that, I'd think?

> >      This would also not yet require any drivers or mac80211 to change =
at
> >      all, since it's just adding a new capability.
>=20
> Oh! Do you mean not add all the things now at link level? and add=20
> afterwards as per requirement/ while adding new capabilities?
>=20
> or add as of now and let driver/mac80211 filling those capabilities=20
> handle it later part on.

I just mean wrt. the patch sequence.

As it is now you're making a lot of changes to drivers/mac80211 during
the cfg80211 patches (specifically patch 4), but then in some sense you
*undo* the need for those later (after patch 7 a lot of the driver
changes aren't _really_ needed, particularly for non-MLO drivers).

That seems harder than it should be. We later have a lot of the fields
back that were modified earlier, so I'm suggesting to just not do it
that way, but rather keep _all_ the fields, then you don't have any
driver changes.

Then add all the fields for each link, and the nl80211 code, aggregation
code, etc.

And _then_ you can start moving things over much more easily, like
mac80211 would start providing per-link stats for all the fields, and
accumulated stats about removed links in the original "non-MLO-
statistics" fields (regardless of whether they're reported that way
because the connection isn't MLO, or because the driver wasn't updated.)


> >      Oh, in terms of allocation - the struct isn't huge now, do we even
> >      care about simply adding 15 links? It still stays well below a
> >      page as far as I can tell ... keep it simpler for now?
>=20
> Okay! but although many fields are more applicable at link level. So=20
> isn't keeping the pointer is better then keeping array[15](seeing error=
=20
> with array [15], mentioned below)?

Right ... hm. I actually thought this struct was already not on the
stack, not sure why. That's why I was talking about the size of
allocations etc.

Alright, since we already have cfg80211_sinfo_release_content() it seems
easier now to actually allocate the link stats dynamically, so instead
of what I just said in my other email:

	struct link_station_info links[15];

we'd have

	struct link_station_info *links;

and then just make sure we allocate a 15 links array, and free it in
cfg80211_sinfo_release_content().

That actually it looks the same for the users, e.g. "sinfo.links[3]".

johannes

