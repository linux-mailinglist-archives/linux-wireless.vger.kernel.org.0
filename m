Return-Path: <linux-wireless+bounces-28872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CF5C527A3
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 14:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8073A25A0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921AE330B33;
	Wed, 12 Nov 2025 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cpUwNsRh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2ED2D5C97
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953554; cv=none; b=Uc6yjsAqJ81k8+dHnUispTNpUF7FpNyEXQS9eXa7kRJV8yjlkyJgC57h5GttkMjeEk+zAufB3CQBK6RfqqsrbPJDfakuuVVA/x5ZM4TiI76z7fI9miU60c+qBTpglybuptB/HeAZiUkRShHeol+qP5QjnM85WH3VbpUq66f5Lcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953554; c=relaxed/simple;
	bh=u2uXUI2vbgzhoV9RrBaU+N0dJoHGiLMGm77aGeKA0Rs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FLqaXbXpGyurxaNxvbjcKejIVH6mOzZLreWIQFIdd5RdNuhj46NJddk3lCN7vzW4K5b+ak0PWcbgdoy0ZdGc22lQHar55JmZJeQAKiAzpMgZujbBXhR/63VQO/Ud8Z24aVVbxHf4VSO6LVNDXvc2DZDl85ae9MyAjomMm4Nttzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cpUwNsRh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=31zCEBSI4htSpSFQJtXgAibTEVV6iSOjngH+wZPS/4A=;
	t=1762953553; x=1764163153; b=cpUwNsRhkiEw1scKuiOoS3B9NLlY9Q6JtsMKuv6EYiFunyU
	4EExAh2ZZ2eCk6u7hgt9PA3K7WFOy0dEWtO2Z6wpL0OhSfUQP2+OtBxTZRgNTL4w+u2Tf03pfe5i0
	3Sh4dS4K0qVoNwDfUSifb+GnebdgmW2ifB7BCqu4aLU8HBylqGPrEZXsVjGH8tI0R7AyjdaO28/zU
	ECjARJ6Tzq/RN91QuM9vQCROcU3m0C911P1kr8BhctssbXP2/HlfhjFsgW4Wz0i1Y1QpsmPZoTZ+h
	gBMGqtRtubck5bIvIAGC4u4FhxR5fgSU2DDZrbIyiw4Bb+5pOp9jUFeSLbxHAS0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vJAkf-00000001TgB-1qpE;
	Wed, 12 Nov 2025 14:19:09 +0100
Message-ID: <080a729f1b10f767aa1b407f454667b83f5ee917.camel@sipsolutions.net>
Subject: Re: [PATCH v3 4/5] wifi: mac80211: refactor CMAC crypt functions
From: Johannes Berg <johannes@sipsolutions.net>
To: Chien Wong <m@xv97.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 12 Nov 2025 14:19:08 +0100
In-Reply-To: <20251111145759.111691-5-m@xv97.com>
References: <20251111145759.111691-1-m@xv97.com>
	 <20251111145759.111691-5-m@xv97.com>
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

On Tue, 2025-11-11 at 22:57 +0800, Chien Wong wrote:
> ieee80211_aes_cmac() and ieee80211_aes_cmac_256() are almost the same.
> Merge them. This removes duplication.
>=20
> It should be noted that the refactored ieee80211_aes_cmac() permits
> 8 bytes output for CMAC-256 and 16 bytes output for CMAC-128. In such
> cases, it would generate result correctly as expected.

I think you got that the wrong way around? Or I don't understand it.

> All references to the refactored functions in the tree are adapted.

Not sure what that means? You also had that comment in another place? Do
you literally mean "I had to change the callers"? That seems obvious?

>=20
> Signed-off-by: Chien Wong <m@xv97.com>
> ---
>  net/mac80211/aes_cmac.c | 53 ++++++++++-------------------------------
>  net/mac80211/aes_cmac.h |  4 +---
>  net/mac80211/wpa.c      | 16 ++++++++-----
>  3 files changed, 24 insertions(+), 49 deletions(-)
>=20
> diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
> index 01fb8b6c5dfb..588e3c9879b3 100644
> --- a/net/mac80211/aes_cmac.c
> +++ b/net/mac80211/aes_cmac.c
> @@ -16,20 +16,21 @@
>  #include "key.h"
>  #include "aes_cmac.h"
> =20
> -#define CMAC_TLEN IEEE80211_CMAC_128_MIC_LEN
> -#define CMAC_TLEN_256 IEEE80211_CMAC_256_MIC_LEN

Oh, now you did? OK I guess that's fine too.

>  #define AAD_LEN 20
> =20
> -static const u8 zero[CMAC_TLEN_256];
> +static const u8 zero[IEEE80211_CMAC_256_MIC_LEN];
> =20
>  int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
> -		       const u8 *data, size_t data_len, u8 *mic)
> +		       const u8 *data, size_t data_len, u8 *mic, unsigned int mic_len)

could trivially keep that in 80 cols, and that would even look better :)

>  {
>  	int err;
>  	SHASH_DESC_ON_STACK(desc, tfm);
> -	u8 out[AES_BLOCK_SIZE];
>  	const __le16 *fc;
> =20
> +	if (mic_len !=3D IEEE80211_CMAC_128_MIC_LEN &&
> +	    mic_len !=3D IEEE80211_CMAC_256_MIC_LEN)
> +		return -EINVAL;

I guess it's a bit annoying that we need this, but OTOH this is not the
optimal path (it's SW crypto...) so I guess doesn't matter.

> +	if (mic_len =3D=3D IEEE80211_CMAC_128_MIC_LEN) {
> +		u8 out[AES_BLOCK_SIZE];
>=20
> +		err =3D crypto_shash_finup(desc, zero, mic_len, out);
>  		if (err)
>  			goto out;
> +		memcpy(mic, out, mic_len);
>  	} else {
>=20
> +		err =3D crypto_shash_finup(desc, zero, mic_len, mic);
>  	}

Arguably, since it's a SW fixup path, you could also just always copy,
using the mic_len =3D=3D IEEE80211_CMAC_128_MIC_LEN path (since it copies
mic_len).

johannes

