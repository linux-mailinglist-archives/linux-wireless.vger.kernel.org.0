Return-Path: <linux-wireless+bounces-23003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE8AAB84FB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A11169FEF
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C032129827D;
	Thu, 15 May 2025 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N9v53oFf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22AF28750D
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308630; cv=none; b=O4rnQnRXHkvPmClIxZiWlqyaO4Dx8fNilxSsc+D+H3cp4MBy3d4mvMyjH9z8J+JiMsWFMGnh+7Tsn3r+B4PPHqmcE1MbIjsK6SY6gdHOwt3JTd1kYFxEpoPTUsxg/QE3GiQ6D24tAKoYgEXSWJSVLgxbwaMTOPPw0ho4f+Mouk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308630; c=relaxed/simple;
	bh=Y40kbAoO1lCgquHUFSl/ffcPcVdR/pn0rpmfluwYcpw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DcniE4P7kxaIWQ3tDXccN9P5l+R87qZ8/X16oM8rHDg2MjMhoinsVw+o+cRkXLaGzSHkTeTRnoj5Q5K6GMF2m4FMLEhCvyc6HNA9uuPsSixVGSFR6KcGtkoE4XyHHaXAGh33VaPce+rPq7hale3HKHXaz5Ee6wU1SwpcTQikwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N9v53oFf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Nlo4hoQmZh0jdAA1x5HBP0oTff9nB9/BapQnUfrpvp8=;
	t=1747308629; x=1748518229; b=N9v53oFfFvYtB/oC2vrYWzxO9F7lZnOUIR5poi8jVltAXfz
	CDPGXo7t15wmLC0XPmGYDO5OssvUSaJXtX0tynVugKa8YlQFTXFftgfL6WMIR8H9dyxWoTu1AvabR
	vv/07LAxcoQf5WNz6d/N45XhP2g6LZ3VN0W/pysVU6EP9/Ut1YOixmA7GBjw3meoLVGMjK9zxVpON
	SWTsVYB0nyck973b4ATp8q8AXeL/bqZ4VP85L77x1a7IOfPGIxZPLGF7GDjAVrJMd5jZrYPDUHjHg
	AibfZ935Bz7Wpogp8yTXaOGLuleonkIihUnUwpqpGoi4pPzDGNjezKQK88G03ofg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWnB-0000000B6nu-1kox;
	Thu, 15 May 2025 13:30:25 +0200
Message-ID: <52d96a61f56cd37b297e12b7ffb2936a479607ea.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:30:24 +0200
In-Reply-To: <20250515054904.1214096-7-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
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

On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>=20
> +void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
> +					     struct station_info *sinfo)
> +{
> +	/* Resetting the MLO statistics for accumulated fields, to
> +	 * avoid duplication.
> +	 */
> +	sinfo->tx_packets =3D 0;
> +	sinfo->rx_packets =3D 0;
> +	sinfo->tx_bytes =3D 0;
> +	sinfo->rx_bytes =3D 0;
> +	sinfo->tx_retries =3D 0;
> +	sinfo->tx_failed =3D 0;
> +	sinfo->rx_dropped_misc =3D 0;
> +	sinfo->beacon_loss_count =3D 0;
> +	sinfo->expected_throughput =3D 0;
> +	sinfo->rx_mpdu_count =3D 0;
> +	sinfo->fcs_err_count =3D 0;
> +	sinfo->rx_beacon =3D 0;
> +	sinfo->rx_duration =3D 0;
> +	sinfo->tx_duration =3D 0;
> +
> +	/* Accumulating the removed link statistics. */
> +	sinfo->tx_packets +=3D sta->rem_link_stats.tx_packets;
> +	sinfo->rx_packets +=3D sta->rem_link_stats.rx_packets;
> +	sinfo->tx_bytes +=3D sta->rem_link_stats.tx_bytes;
> +	sinfo->rx_bytes +=3D sta->rem_link_stats.rx_bytes;
> +	sinfo->tx_retries +=3D sta->rem_link_stats.tx_retries;
> +	sinfo->tx_failed +=3D sta->rem_link_stats.tx_failed;
> +	sinfo->rx_dropped_misc +=3D sta->rem_link_stats.rx_dropped_misc;

Setting something to 0 just to +=3D it seems silly?

However I think it also needs a bit more explanation - it's sinfo, so
it's zeroed at allocation, where would non-zero numbers come from?

johannes


