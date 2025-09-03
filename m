Return-Path: <linux-wireless+bounces-26974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20B0B4242F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 16:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7D31A81850
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0283C30BF77;
	Wed,  3 Sep 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="I4fXu0+1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9CA932
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911478; cv=none; b=YDqlOv36x/TUXUhqKxuAfMezqLdK4YyxPpw1Fwuq3duHeMtxYpB1aH8WGhratYhRC/6/NFc0GTtA1SECldtE8+RYlS1fxbep6OD1Blvhyj0ntw+vzRYT2GyAvkgGYmO2epRrBuoOHjKYQJPJNcqAd0PgwZSQNAW9GeTOY3nBo24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911478; c=relaxed/simple;
	bh=jSaRbnWvZs6Ci4Ei6BFZK9mWgFy5J8LHvIpHzLjnEYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFFRxX4f2GfST/gZdlk7lNlMrqanVr9ueGDG6Thq35oTpdGTTpTny9fCYCg8DvweQ9oOEHqU5JsmqLpku8CgTNvlB8eVDopY/DTKWTAeNNd0iZY9DufmWNo7VJpDFM5YdA/D64YZYplv4eQH/A1t1Hy8VvWvxrG3FPDrFYWdqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=I4fXu0+1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jSaRbnWvZs6Ci4Ei6BFZK9mWgFy5J8LHvIpHzLjnEYo=;
	t=1756911477; x=1758121077; b=I4fXu0+1M9XCYor19LLP0eWGgTXhVjubCQ0UXjrAGUvVUGi
	7bAmSnPHLwATTpXRQv2MhJCnOL5ddpUUMXsU+y9GdcEMbgePckF24TyuiHA7BfXu310CtfsmRxlSO
	k5ljRdNsSCi8kROnDfEYDtez2zQM5I5k2wh16/MttjinyCKL78/t4Jwm00O21d7J1BygMT20zrD4y
	pmBf2WDxIrZ5DBPBGSaFeh5FzGsh/NuD6B7bUhawHeNGTxdagw663fGEGe+YYcHuCacIJijc/Qb49
	MxsqkLXMz338qIxiEO4q2u32PCvohvGXK1/bbuAbyYyS4A2ubCydFjxpCUCHd1RQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1utovq-0000000C0oh-04kE;
	Wed, 03 Sep 2025 16:57:54 +0200
Message-ID: <6644d4195e003b5d4c7c1cfaf61c55c7e3d3c942.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: fix reporting of all
 valid links in sta_set_sinfo()
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Sarika Sharma
	 <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 03 Sep 2025 16:57:53 +0200
In-Reply-To: <c3312127-0b87-4825-bf73-05351f8eb55e@oss.qualcomm.com>
References: <20250822053229.519836-1-quic_sarishar@quicinc.com>
	 <b8eb835bb73e348c331e008408159a8026d28870.camel@sipsolutions.net>
	 <c3312127-0b87-4825-bf73-05351f8eb55e@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-09-03 at 07:22 -0700, Jeff Johnson wrote:
> On 9/3/2025 1:01 AM, Johannes Berg wrote:
> > On Fri, 2025-08-22 at 11:02 +0530, Sarika Sharma wrote:
> > > Currently, sta_set_sinfo() fails to populate link-level station info
> > > when sinfo->valid_links is initially 0 and sta->sta.valid_links has
> > > bits set for links other than link 0. This typically occurs when
> > > association happens on a non-zero link or link 0 deleted dynamically.
> > > In such cases, the for_each_valid_link(sinfo, link_id) loop only
> > > executes for link 0 and terminates early, since sinfo->valid_links
> > > remains 0. As a result, only MLD-level information is reported to
> > > userspace.
> > >=20
> > > Hence to fix, initialize sinfo->valid_links with sta->sta.valid_links
> > > before entering the loop to ensure loop executes for each valid link.
> > > During iteration, mask out invalid links from sinfo->valid_links if
> > > any of sta->link[link_id], sdata->link[link_id], or sinfo->links[link=
_id]
> > > are not present, to report only valid link information.
> > >=20
> > > Fixes: 505991fba9ec ("wifi: mac80211: extend support to fill link lev=
el sinfo structure")
> >=20
> > With a Fixes: tag for a commit in 6.17-rc, why should this not also go
> > to wireless for 6.17?
>=20
> Concur this should go through wireless instead of wireless-next. That was=
 a
> miss on my part during internal review.

Sounds good. Hopefully I'll remember when I apply patches after wireless
gets pulled, maybe resend if you want to make sure :)

johannes

