Return-Path: <linux-wireless+bounces-19588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A65EA49A83
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475253B3F03
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B41626B972;
	Fri, 28 Feb 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mDAlTsGv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2819B1D555
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749258; cv=none; b=KY+Yds0tU26xqzAAeNBXZ+L55dv8Nls1hNjRKlOpbWj907Xge2FND4KMxCSodXQBxPMSbDU6rKHE90Cn8ruKTOySzdSDU8tw7XxGZ+Ldsc7PqytvkRVDcedCU/tyz77ABNj6oDTR6y2/K2eRsoprX0Z8buyKyWBksAqdnwsmFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749258; c=relaxed/simple;
	bh=wsz1houGAbWt62o/FBOb/YkxEZfpn12mqHw+0h+GlPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+CgHr8HdpL9Hyzsm9RgUC2NlFN0mFj/mzsAt4iP0GWS/MA/zqammfaYuJ8z8YYwvGMzN7cmnxmLKRcmkDVT2LQzeKVmjiBZhbQH5NJgNMchLnp1YqFNHJ69btlRhAXa1VquQyCecmyp9fdiKU9fg05i+eadEePO3IJ+UMFLhjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mDAlTsGv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1u1FP51eXukP0YK6a7yMlq4+uJsGw7QM9O/2EEtIHEs=;
	t=1740749257; x=1741958857; b=mDAlTsGvTK4C2xgvrLdsWtLiwHq1ivPo/eoZCHPgTl2PZ8l
	IKRnH/kSklhM4GX0ynXUzQK3M7zeoeUU1EZMx6eKPNGnaN1hxOZqHA9igcvqpuKYyKQOR4ZeeFwAX
	GQGHfsEPfIs6l9R0VIf1QmSX1kwFlVAPXPFQiBGwznxsEuXOck0sHetFDD9O0x/BOXs4ujGd+oRMr
	LHl4+rCUjQtBjxQzjoxcTmGfixnOls6ZZfgkaS8QLMpJQrOkL1bHqvNe48r8Ar6AvZyBBW6yT8le2
	FsBSDRTutsOMwdr+CGqmMlb/dN1zbCGPjTYYvDWy1O2KWZlehYgGblDcsC1jFddQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1to0Os-0000000DlMd-0ALu;
	Fri, 28 Feb 2025 14:27:34 +0100
Message-ID: <193193c23778b6b3c8c786d56b9a28046a35db60.camel@sipsolutions.net>
Subject: Re: [PATCH v3 11/12] wifi: cfg80211: add additional MLO statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 14:27:33 +0100
In-Reply-To: <20250213171632.1646538-12-quic_sarishar@quicinc.com>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
	 <20250213171632.1646538-12-quic_sarishar@quicinc.com>
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

On Thu, 2025-02-13 at 22:46 +0530, Sarika Sharma wrote:
>=20
> +	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) {
> +		if (!nl80211_put_sta_rate(msg, &sinfo->txrate,
> +					  NL80211_STA_INFO_TX_BITRATE))
> +			goto nla_put_failure;

You don't need nested ifs where && will do just fine.

> +static void cfg80211_sta_set_mld_rate_info(struct rate_info *sinfo_rate,
> +					   struct rate_info *link_sinfo_rate)
> +{
> +	if (link_sinfo_rate->flags)
> +		sinfo_rate->flags =3D link_sinfo_rate->flags;
> +	if (link_sinfo_rate->legacy)
> +		sinfo_rate->legacy =3D link_sinfo_rate->legacy;
> +	if (link_sinfo_rate->mcs)
> +		sinfo_rate->mcs =3D link_sinfo_rate->mcs;
> +	if (link_sinfo_rate->nss)
> +		sinfo_rate->nss =3D link_sinfo_rate->nss;
> +	if (link_sinfo_rate->bw)
> +		sinfo_rate->bw =3D link_sinfo_rate->bw;
> +	if (link_sinfo_rate->he_gi)
> +		sinfo_rate->he_gi =3D link_sinfo_rate->he_gi;
> +	if (link_sinfo_rate->he_dcm)
> +		sinfo_rate->he_dcm =3D link_sinfo_rate->he_dcm;
> +	if (link_sinfo_rate->he_ru_alloc)
> +		sinfo_rate->he_ru_alloc =3D link_sinfo_rate->he_ru_alloc;
> +	if (link_sinfo_rate->n_bonded_ch)
> +		sinfo_rate->n_bonded_ch =3D link_sinfo_rate->n_bonded_ch;
> +	if (link_sinfo_rate->eht_gi)
> +		sinfo_rate->eht_gi =3D link_sinfo_rate->eht_gi;
> +	if (link_sinfo_rate->eht_ru_alloc)
> +		sinfo_rate->eht_ru_alloc =3D link_sinfo_rate->eht_ru_alloc;
> +}

I don't understand the if statements here. Many of these do not have a
value of zero meaning "unknown"?

johannes

