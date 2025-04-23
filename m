Return-Path: <linux-wireless+bounces-21935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F57A995C8
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7853BEFAC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D536D288CA0;
	Wed, 23 Apr 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dIm7MnwT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E374281370
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427162; cv=none; b=PxcLZ8oZ9eqKHQM/orHLEOlm7KBOlEgGnG71oRHJIgekdzfqgdrZ6tRg/rtWgknK9Q52OaSf3Zp5LKYz9tQG/DJqblss1J2UioHe5osHz8KIoimHUBRUUrYhpPXRGgsnouxEyrvLxUjIwkmzB3eV7hF9qDX1rYIUW4ME78oL1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427162; c=relaxed/simple;
	bh=z71hHNwjRWlrlYbor66hlXNQ6DxFx6Q11DhUBr+6XyY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p9iUmemY16doHFF7Yu07btop+FrZWMSzzMJSY8EHlTCOI3gv+vKNYJ4II2t06R/K7ikBdpub/BCD0Pe0W8zzxUSUhiJeAeA0Z+D6akANXPCcnoIktTxE5utQ0jMqmLJy0FRdHGfEKE6hnC0Xj4xlmgDuXir+5RiazXLp8Q/MKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dIm7MnwT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ve8OXH0MBrIMwtwNXepI+lqcteOK3cBzZkQH5+8UuM8=;
	t=1745427161; x=1746636761; b=dIm7MnwTf3jaC9Ez+p18uSpQub7iXEBZKv6MWFX/mxvXkaf
	uqkrzJVba9e11wuKnY4b8aCtGbr/WRNcBHV2giH5x9hYkFh2iqu2Gq+mZ2nvZZEI8kl+XtWsWz0bK
	X+1Yhu9x6eZyM44vTUfRaaqI03fVyJVNZWuzg/qvRtgENbvQHdjA7eKe6w4LXo6NRUvX4YANduyVy
	AGf3Kf6xCnT7KmKTvuwE9DPBNz6e/pNmFGqjIHanhAOfwcrGNQ0oahNFzqjHUejj+vPng8ik+kJFl
	vJfv3BzcQYR+uTBbJOXGrDuYLbY9v3kIFi9gBX+n5XbIhx4uetAxxGZ6Pg2tpUpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7dKv-0000000Et3c-3ANM;
	Wed, 23 Apr 2025 18:52:38 +0200
Message-ID: <fa49a2d4927868be689ed8464aa27c3aad2f03b6.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 04/11] wifi: cfg80211: reorg sinfo
 structure elements for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 23 Apr 2025 18:52:37 +0200
In-Reply-To: <20250415042030.1246187-5-quic_sarishar@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
	 <20250415042030.1246187-5-quic_sarishar@quicinc.com>
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

On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
> Current implementation of NL80211_GET_STATION does not work for
> multi-link operation(MLO) since in case of MLO only deflink (or one
> of the links) is considered and not all links.
>=20
> Therefore to support for MLO, start reorganizing sinfo structure
> related data elements and add link_sinfo structure for link-level
> statistics and keep station related data at sinfo structure.
> Currently, changes are done at the deflink(or one of the links) level.
> Actual link-level changes will be added in subsequent changes.
>=20
> Also currently, mac80211 ops .sta_statistics() is mapped to fill sinfo
> structure. But to add support for station statistics at link level,
> change the ops to .link_sta_statistics() to fill link_sinfo structure.
>=20
> Additionally, move connected_time before assoc_at in station_info
> structure to get minimal holes.
> pahole summary before this change:
>  - size: 232, cachelines: 4, members: 23
>  - sum members: 223, holes: 3, sum holes: 9
>  - forced alignments: 1
>  - last cacheline: 40 bytes
>=20
> pahole summary after this change:
>  - size: 224, cachelines: 4, members: 23
>  - sum members: 223, holes: 1, sum holes: 1
>  - forced alignments: 1
>  - last cacheline: 32 bytes
>=20
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
> ---
> NOTE:
>  - Included driver changes for fixing compilation issue.

Does this really need to do all the changes in mac80211 and the drivers?

OTOH maybe if not then it would cause much more back and forth?

> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
> @@ -1810,47 +1810,51 @@ static int ath6kl_get_station(struct wiphy *wiphy=
, struct net_device *dev,
>  	else if (left < 0)
>  		return left;
> =20
> +	sinfo->links[0] =3D kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
> +	if (!sinfo->links[0])
> +		return -ENOMEM;
>=20

This seems rather error-prone to me.

We already have sinfo->pertid today, allocated and freed by cfg80211,
and here you've added something that's allocated by the driver and freed
by mac80211. That seems odd in comparison?

I'm not sure what the choices are, but I can't say I like this one ;-)
Maybe it's still the least bad option.

>  	if (vif->target_stats.rx_byte) {
> -		sinfo->rx_bytes =3D vif->target_stats.rx_byte;
> -		sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
> -		sinfo->rx_packets =3D vif->target_stats.rx_pkt;
> -		sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
> +		sinfo->links[0]->rx_bytes =3D vif->target_stats.rx_byte;
> +		sinfo->links[0]->filled |=3D BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
> +		sinfo->links[0]->rx_packets =3D vif->target_stats.rx_pkt;
> +		sinfo->links[0]->filled |=3D BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
>  	}

You later (patch 7) add support for accumulated statistics. These are in
the struct station_info.

Why do we need to make these changes to non-MLO drivers at all? It
stands to reason that for non-MLO drivers we could mostly use the
accumulated statistics? That'd at least be 9 of the values changed here,
they just come back as is in patch 7.

I don't think it really matters for non-MLO whether or not link[0] is
used or the overall STA/accumulated fields?

A similar argument can be made for what's later called 'mld_addr' and
some other fields, I'd say?

Perhaps it'd be better to structure this patchset the other way around:
start with the existing non-MLO and move out things that are clearly not
applicable at all to the MLD level (such as RSSI, rates, etc.). It seems
plausible that'd really be less than you have now, since the
accumulation (patch 7) adds back a bunch and should possibly add back
more than it does (e.g. tx/rx duration, MPDU count, etc.)


I probably need to spend more time with this ...

johannes

