Return-Path: <linux-wireless+bounces-5485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79E8907BB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB8C1F280DB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC931350C6;
	Thu, 28 Mar 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="b46XEUj2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF71327F6
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648464; cv=none; b=R1ZtU1dgGKxhZWDZlraVF/7wPDG09AcdwHT/BTeDOF3nb3ieSAF4J//CBBQjQZ4jV4QGkdDFisodM70679ZtNqG6x3F3q2cXnNIHNiK97etGl3YdOKkKxVjQywmO97O0Ql+A1r7S6Djff7Wqi5uywMwKtIgl08138geoCCYjZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648464; c=relaxed/simple;
	bh=uhgARVDlTR79mRxevKk9fKEXKk+7wbwsaUclyGM+9WA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B8PGPawGoP5pc6ju13UpCZook2BTR5E/8iHX9qAlcUKnGsu+khJ/AW+isa6x872RFFrMrj6TXgmbhMwjwFRuFmkLRuG1yEWpUn/jb2Ik5SOL8h3SniQiQYWTA+9XoAP3qeNxPnjpL78NcRfL10tnj/2CiqQ1dIXXh432P4aB8WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=b46XEUj2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uhgARVDlTR79mRxevKk9fKEXKk+7wbwsaUclyGM+9WA=;
	t=1711648462; x=1712858062; b=b46XEUj2wUNSQ/QJmPbcib6HaLZHu/LQ988d9mb+QeEUllr
	RmxYajaJzGzMp+yzzXwuilVji4wf40VdNEA65MGEowo3eQWz1FWMGP3nt1MaVFY2eKpaAjJQ78D+6
	R/Ef/SMx6sU48IiAK8387k44Pcvu5xCiKRhlzrqztZLWzI8Wp+OISbeZVW7qns8VRKDIkEAVirnc+
	ruFHff31tFrJ3uSiXCqVNfz9PEnsgkxBofqYGlvS+qiwhJqbPZwZ7ubtbkFH1eLD9t5LhSinHRL6V
	08LWGHZaPPxrUSU6evy8/OJwfMKQZtl1c5Y0xo7d/OUeikIJ6PC0w6llkzmZbpgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rptxD-00000001C7S-16Yh;
	Thu, 28 Mar 2024 18:54:19 +0100
Message-ID: <3f6de100163a8521ab09929abc537e57d26dafea.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: Add support to rx retry
 stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Hari Chandrakanthan <quic_haric@quicinc.com>, Jeff Johnson
	 <quic_jjohnson@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 28 Mar 2024 18:54:18 +0100
In-Reply-To: <4d569d40-d0a8-10d5-7e6d-4c9c03c14371@quicinc.com>
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
	 <20240319134522.4021062-2-quic_haric@quicinc.com>
	 <d364e872eb29f03236630bab49a3243e2118ab22.camel@sipsolutions.net>
	 <14699537-99b2-e468-6a7b-7b721193400e@quicinc.com>
	 <b9dfab64822bacf0cc72380c0de034b79d489668.camel@sipsolutions.net>
	 <68c6fcbd-0aaa-43b2-b5e2-08367c11e79d@quicinc.com>
	 <f5cb9edcea875920e0ce156be76d06c78d1279ec.camel@sipsolutions.net>
	 <4d569d40-d0a8-10d5-7e6d-4c9c03c14371@quicinc.com>
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

On Thu, 2024-03-28 at 22:49 +0530, Hari Chandrakanthan wrote:
> On 3/27/2024 8:37 PM, Johannes Berg wrote:
> > On Wed, 2024-03-27 at 08:02 -0700, Jeff Johnson wrote:
> > > > I'm also imagining that we change the API from cfg80211 to the driv=
ers
> > > > to get the *link* STA information, and do the summing up and/or "be=
st"
> > > > selection there in cfg80211 itself. However, I am prepared to accep=
t the
> > > > possibility that we may do _both_ in the API, if not all drivers ca=
n
> > > > even do all of the statistics per link. We should probably still ha=
ve
> > > > the link STAs in the statistics in nl80211, but then they may not b=
e
> > > > populated?
> > > First remember that there are a lot of statistics, and each driver is=
 free to
> > > return as many or as few as they support, indicating the ones they ar=
e
> > > returning using the "filled" bitmap.
> > Yes, I'd think we want to use the same data structure for both, though
> > setting something in *both* links and *mld* would (should) be an error.
> The statistics can be populated by driver or mac80211.(say tx retries,=
=20
> tx packets etc)

Right.

> So we should also change the existing stats update in mac80211 on link=
=20
> STA basis instead of deflink?

Absolutely, we need to do that, it's been on my list forever, since the
early MLO work... I'm a bit torn between not wanting you to have to do
all that work (even if we know that we'll have to do it) and on the
other hand not wanting to make it worse with more statistics now ...
There's no good middle ground here though now.

> > Good point, when they're really removed we'd want to probably keep that
> > value as a bias for the MLD-level stats?
>=20
> ok. Then the statistics value in MLD STA would be bias + summed up value=
=20
> of currently alive links?

I guess? But I'm not sure where we'd actually _keep_ the bias values.
Maybe give up on that idea that cfg80211 could sum it all up, and just
require the underlying driver (or mac80211) to report both per-link and
total stats, where available? That way, mac80211 could keep the bias
somewhere and just add it to the total before reporting _that_.

> On the same line , ethtool stats(*interface level stats*) in=20
> mac80211(ieee80211_get_stats())
> computes the stats by summing up the current STA statistics.
> Here stations can come and go and the ethtool stats may not reflect the=
=20
> total packets transmitted or received by the interface.
> It just reflects the summed up value of current alive stations.

Yeah ... I know Ben loves it, but personally I kind of think of ethtool
as a dead legacy interface for this respect, it just doesn't have the
ability to reflect the required structures/hierarchy/etc. well since
it's just a flat list. Sure you can structure the names in some way, but
it's iffy at best. I'd just ignore that for now. If we have better
statistics to nl80211, we can always make ethtool support on top of
that, perhaps even moving it to cfg80211, if we even need more support
there. I'm not hugely in favour, but if it stays contained somewhere and
consumes existing APIs I'm OK with it.

> Since these two problems are similar (ethtool stats and MLD stats=20
> calculation),
> would like to understand what type of value would be more useful to user?
>=20

What do you mean by that?

johannes

