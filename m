Return-Path: <linux-wireless+bounces-21926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C110A993B6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9FF4A22AB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ECE28C5BC;
	Wed, 23 Apr 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ihRlP8w8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120628C5A4
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422585; cv=none; b=oBMaFoOgVIACXLfAIt/wQghbDoG3x13G4D/RXOI7vzewetQopBC+fZtMNy/+QksMeRxDew/JSp4L2meEavf5SWiPqe1AWzgVvv1kt/RrBbCLlFcBd5fQQgQR3VtHuZvOTKnYpxyc0fZ5HiGvhpOM9ELzmu8y4T6nSWTNZzCNN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422585; c=relaxed/simple;
	bh=y2EbxWFBigsWYat9WNcAdTZL7HjGbiMxgbLjNLfwSqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RK2t3DZ47DNaOswFPmAQSMEHAHj5DFLVqKQkNOCwmMYPn2Ic13ZcpdhBRlMPs/zTYcN7SsUulX/pi7V0BtwwHkBkgegtnBc1XKrjRR0NBh9lYLIsdVn5/mpwuCi08qI7LXGeL+k+abYY+gs/bP3j2fAnI0yA167v/57UNGjWbtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ihRlP8w8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=x1hQoeaxTOnALc2XFtP8ibEgRH+I3Cmj+d9fihNKVX8=;
	t=1745422583; x=1746632183; b=ihRlP8w82vIIgB2UYJRWUeTTBN72vA+VrTdvErrjoWf0om5
	vqTIqx40vpa3ylglasbTJGGkIqufKrRzH9IaYzaL9v8FWhK83maZ1+UiV8nBu47bwxlEsQKrktVqL
	MEeB8qfkPyPOF71ZqoZnXByklg+ub2CVYwD1D38m0AT10Wlx8WSA8bwx6TJKe8LFR8K3MnuZ0ZkPT
	inq+2hMblHNxcfLWRuN1p2g6Xo5IS58uaWt7a4mIlOxv7NMI30IfdKIb4pMCM21cmVCHj8W08LtC/
	3H03K7RhbKTFCa+BH007jcl9XVp5PXlJlMCWcqcFx7hfpeO2mIb68hRZhLBYWSAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7c96-0000000EnU1-0ycm;
	Wed, 23 Apr 2025 17:36:20 +0200
Message-ID: <bef48349364854ba2ec42262e91b747028310a1c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 1/5] wifi: cfg80211: Add Support to Set
 RTS Threshold for each Radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 23 Apr 2025 17:36:19 +0200
In-Reply-To: <20250328122519.1946729-2-quic_rdevanat@quicinc.com>
References: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
	 <20250328122519.1946729-2-quic_rdevanat@quicinc.com>
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

On Fri, 2025-03-28 at 17:55 +0530, Roopni Devanathan wrote:
>=20
> -static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 cha=
nged)
> +static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, s8 radi=
o_id, u32 changed)

nit: all those lines could be shorter. I'm surprised you even did that
by hand rather than spatch ;-)

>  #define NL80211_WIPHY_NAME_MAXLEN		64
> +#define NL80211_WIPHY_RADIO_ID_DEFAULT		-1

It seems to me that should't be in nl80211.h, since it cannot be used by
userspace, and is internal anyway?

And why should the attribute even be signed, when you explicitly reject
negative values anyway? Seems like it should simply be unsigned?

> +	/* Allocate radio configuration space for multi-radio wiphy
> +	 */

what happened there

> +	if (wiphy->n_radio > 0) {
> +		int idx;
> +
> +		wiphy->radio_cfg =3D kcalloc(wiphy->n_radio, sizeof(*wiphy->radio_cfg)=
,
> +					   GFP_KERNEL);
> +		if (!wiphy->radio_cfg)
> +			return -ENOMEM;
> +		/*
> +		 * Initialize wiphy radio parameters to IEEE 802.11 MIB default values=
.
> +		 * RTS threshold is disabled by default with the special -1 value.

unnecessarily long lines

> @@ -1185,6 +1202,7 @@ void wiphy_unregister(struct wiphy *wiphy)
>  	cfg80211_rdev_free_wowlan(rdev);
>  	cfg80211_free_coalesce(rdev->coalesce);
>  	rdev->coalesce =3D NULL;
> +	kfree(wiphy->radio_cfg);
>  }

Hm. Would be safer in wiphy_free()?

> @@ -3875,50 +3887,79 @@ static int nl80211_set_wiphy(struct sk_buff *skb,=
 struct genl_info *info)
> =20
>  	if (changed) {
>  		u8 old_retry_short, old_retry_long;
> -		u32 old_frag_threshold, old_rts_threshold;
> -		u8 old_coverage_class;
> +		u32 old_frag_threshold, old_rts_threshold, *old_radio_rts_threshold;
> +		u8 old_coverage_class, i;

also long lines

> +		old_radio_rts_threshold =3D kcalloc(rdev->wiphy.n_radio, sizeof(u32),
> +						  GFP_KERNEL);

long line

allocations can fail

you leak it


> +
> +		if (radio_id < rdev->wiphy.n_radio && radio_id >=3D 0) {
> +			old_rts_threshold =3D
> +				rdev->wiphy.radio_cfg[radio_id].rts_threshold;
> +
> +			if (changed & WIPHY_PARAM_RTS_THRESHOLD)
> +				rdev->wiphy.radio_cfg[radio_id].rts_threshold =3D
> +					rts_threshold;
> +
> +			result =3D rdev_set_wiphy_params(rdev, radio_id, changed);
> +			if (result)
> +				rdev->wiphy.radio_cfg[radio_id].rts_threshold =3D
> +					old_rts_threshold;

this is also getting really deep - probably better to refactor this into
new functions for the two cases (with and without radio idx)

>  static inline int
> -rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, u32 chang=
ed)
> +rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, s8 radio_=
id, u32 changed)
>  {

also unnecessarily long

johannes

