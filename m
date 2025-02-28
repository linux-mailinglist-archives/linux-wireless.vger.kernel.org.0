Return-Path: <linux-wireless+bounces-19580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828D9A49A1B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EED33B2658
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572E28371;
	Fri, 28 Feb 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZidfNPo+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424BA2F41
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747701; cv=none; b=uNcdJtXLj5UGWvirSH7j2AzQ78nMmiWzYy1FlZjIPDmxwfrl0Z37vPwc0Hoqfas9/J5fBNElMf+jU77XbXPd6wvchiSm3Bz2i0yyfyyDWb/ALkHDXEY+7NmcdXGEijbwEZZw1HwCQHhlf0mBCk8Jk1zfKeQD6cjafkVI8SrxUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747701; c=relaxed/simple;
	bh=4MB3SQ3TT2F9EocqR4pt8QsukIj2V2T/5ASp7Us/khE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JfpA3x48YpFmId+MgI5CytV4gzUX7K+iNx9TPkebPg+ol16362FIHIAMDdM3Ku4GGU6U5aIVWGRYmpF4snqfSteolXy4jvFZ8dlqVT7zHXE7wIdRMnGWhn2Cg3IjJVAJNAxiob2TBHRYrvdfGLLY9hgZlBemf1XLl4NrgfTRwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZidfNPo+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OzmIZZojPzFOS9a5GR4aXyT9MXjyNvm04Hn8yW4pxo4=;
	t=1740747700; x=1741957300; b=ZidfNPo+WNOjYQM7wXZZbg1O4LdTBv83yzkyJtyjL28RqGb
	mOO3siVSHZPNpe9MSodgyxOYgg4lxb6UGPy6XvTACO+j/ohpXfa//JA4SQXh4LepE9Ntt4YGxYgkk
	KKDrDOpjGKkgQ+Ie308bk7sLLngiUv309ENqJdhMqE4Qkr1U88Q2I6GPuHFdiBzFsEulDeiUpTaKm
	mhNURgE7eVmCiBIC3JbENup3cDKKxbSF3K96y2AyxTNuZK0YUo6+KWH+Wv5zYvII5mt/Ra18esur3
	bxvXB7sdK6g0ZA36fbBfhp+QczYYpc0YWNATCpWGXXyxvhNxvg1m2r+i4/7IWqDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnzzk-0000000DkH5-3wzd;
	Fri, 28 Feb 2025 14:01:37 +0100
Message-ID: <6f25563f9d68f4e2c230ff426cbabec43ea56335.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/5] wifi: cfg80211: Add Support to Set RTS Threshold
 for each Radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 14:01:36 +0100
In-Reply-To: <20250129155246.155587-2-quic_rdevanat@quicinc.com>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
	 <20250129155246.155587-2-quic_rdevanat@quicinc.com>
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

> +/**
> + * struct wiphy_radio_cfg - physical radio config of a wiphy
> + * This structure describes the configurations of a physical radio in a
> + * wiphy. It is used to denote per-radio attributes belonging to a wiphy=
.
>=20

Seems like there should be a blank line after the short description so
it doesn't all end up in there?

> + * @NL80211_ATTR_WIPHY_RADIO_INDEX: Integer attribute denoting the index=
 of
> + *	the radio in interest. Internally a value of 0xff is used to indicate
> + *	this attribute is not present, and hence any associated attributes ar=
e
> + *	deemed to be applicable to all radios

Please document the type here. Also, the description of the internal
0xff handling and all that is inappropriate in the public API
documentation.

However, it seems using -1, would be nicer? Also,
NL80211_WIPHY_RADIO_ID_MAX is a _really_ bad name for that.

> +++ b/net/wireless/core.c
> @@ -1077,6 +1077,23 @@ int wiphy_register(struct wiphy *wiphy)
>  		return res;
>  	}
> =20
> +	/* Allocate radio configuration space for multi-radio wiphy.
> +	 */
> +	if (wiphy->n_radio) {
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
> +		 */
> +		for (idx =3D 0; idx < wiphy->n_radio; idx++)
> +			wiphy->radio_cfg[idx].rts_threshold =3D (u32)-1;
> +	}

This error handling is obviously all wrong. Please ask someone else to
review before you resubmit.


The later code in nl80211.c could also use some refactoring, rather than
just indent it a bit and call it done.

johannes

