Return-Path: <linux-wireless+bounces-23173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 480A3ABD222
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 10:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E301B6337A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 08:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD6126460B;
	Tue, 20 May 2025 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="T32uLvhq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580426156A
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730342; cv=none; b=Y8shi0w7MmdDfxbyIUUCszWwh2HWJku1JdxpJ9tk2v9Ou+eOMvj15oQo08ejHUhKki5K/Hn3TsxoJ8LltKer6Z/FfyMbh/torUfy/1GUL7H4x3oSvLwtnAGlO1DT9QlE54rpA+EZQmEoGKjI0SD6lhr63Va8PhCwyQDgjoiVG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730342; c=relaxed/simple;
	bh=M/utYPcBlN7dHbmeJRND8OO8Pcpmvy2zrE2yuwxo98w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HunxC3/6YIGwbwiRcqVplVPmatW8tGHiTeT9pOQQyT3Llubr2E9rAVbR+o1UTSX/Xr7IXRK1ZEKECl75Ywz+ACmwpuZoGG4Zm9g76PX9W+ypS1RT3cUA7nhS2VXGoupm+A8oNAYAqE08kXXMCzd/0h3Kzc8NaDokByIYQs61SGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=T32uLvhq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NmBDxJ7jfpqCc4+Zg+gTWbUkln+My88bEojclojZWzw=;
	t=1747730341; x=1748939941; b=T32uLvhqGFUD3JxKYVuiNCjEAGKPk7DiL8bTDvDkj94h+cA
	NbToPE2TdZ6H0e4vqHPkA0lWHFtkA6UBFI/Y5DBXLeNy4Os6zCnJh6KPQJ8L/vsjdHOwuf691k1bM
	Ur2k0HIlaN/UVtHeo9lYYZA8SSP4Mbq8bC0d8HxUwVpLHBY/tRJCJHf9XY50bVxiGce+iTrLe10aw
	sAUMArIH+MMqyYYCTHXnpF44BwJB7XGTU++9qnAB/JXdmzNr0Kt6MxDoTePwcpAn6a5dSu7tAI3H4
	2WUOiibAScaZ1yjQMROf+BTXGaBxlBxaqoVkYdLpX4kvLWzuaOwgq/FQae3Q/+4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHIV0-0000000ApVn-0Hwl;
	Tue, 20 May 2025 10:38:58 +0200
Message-ID: <5ab3ec5c2145bcf31084dc1ebd87a40600d1a505.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 20 May 2025 10:38:57 +0200
In-Reply-To: <f6d6ed3c-54de-4dcb-bea3-8a420f001c9a@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
	 <52d96a61f56cd37b297e12b7ffb2936a479607ea.camel@sipsolutions.net>
	 <f6d6ed3c-54de-4dcb-bea3-8a420f001c9a@quicinc.com>
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

On Thu, 2025-05-15 at 23:05 +0530, Sarika Sharma wrote:
> On 5/15/2025 5:00 PM, Johannes Berg wrote:
> > On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
> > >=20
> > > +void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
> > > +					     struct station_info *sinfo)
> > > +{
> > > +	/* Resetting the MLO statistics for accumulated fields, to
> > > +	 * avoid duplication.
> > > +	 */
> > > +	sinfo->tx_packets =3D 0;
> > > +	sinfo->rx_packets =3D 0;
> > > +	sinfo->tx_bytes =3D 0;
> > > +	sinfo->rx_bytes =3D 0;
> > > +	sinfo->tx_retries =3D 0;
> > > +	sinfo->tx_failed =3D 0;
> > > +	sinfo->rx_dropped_misc =3D 0;
> > > +	sinfo->beacon_loss_count =3D 0;
> > > +	sinfo->expected_throughput =3D 0;
> > > +	sinfo->rx_mpdu_count =3D 0;
> > > +	sinfo->fcs_err_count =3D 0;
> > > +	sinfo->rx_beacon =3D 0;
> > > +	sinfo->rx_duration =3D 0;
> > > +	sinfo->tx_duration =3D 0;
> > > +
> > > +	/* Accumulating the removed link statistics. */
> > > +	sinfo->tx_packets +=3D sta->rem_link_stats.tx_packets;
> > > +	sinfo->rx_packets +=3D sta->rem_link_stats.rx_packets;
> > > +	sinfo->tx_bytes +=3D sta->rem_link_stats.tx_bytes;
> > > +	sinfo->rx_bytes +=3D sta->rem_link_stats.rx_bytes;
> > > +	sinfo->tx_retries +=3D sta->rem_link_stats.tx_retries;
> > > +	sinfo->tx_failed +=3D sta->rem_link_stats.tx_failed;
> > > +	sinfo->rx_dropped_misc +=3D sta->rem_link_stats.rx_dropped_misc;
> >=20
> > Setting something to 0 just to +=3D it seems silly?
> >=20
> > However I think it also needs a bit more explanation - it's sinfo, so
> > it's zeroed at allocation, where would non-zero numbers come from?
>=20
> Currently, the station information for MLO is populated with some values=
=20
> from sta->deflink, as the sta_set_sinfo() call is common for both=20
> non-MLO and MLO.

OK but deflink will not actually _have_ any values. And again, mac80211
shouldn't be doing work the results of which are then only discarded...

> When updating the station_info structure in=20
> cfg80211_sta_set_mld_sinfo(), the accumulated fields (such as packets,=
=20
> bytes, etc.) will already contain values set by mac80211 (from the=20
> deflink fields).

Which arguably is the problem? But also not because those are zero
anyway? I still don't think this makes any sense. Either it's not filled
and remains zero, or it should be filled only with some sensible values
like the accumulated stats from removed links.

johannes

